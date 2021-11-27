require 'test_helper'

describe AdjuntosController do
  let(:usuario) { loguearse }

  describe 'autorizado' do
    it 'muestra los adjuntos del perfil' do
      perfil = create(:perfil, usuario: usuario)
      3.times do
        create(:adjunto, perfil: perfil)
      end

      autorizar do
        get :index, perfil_id: perfil.id
      end

      must_respond_with :success
      _(assigns(:perfil)).wont_be :nil?
      _(assigns(:adjuntos)).wont_be :nil?
      _(assigns(:adjuntos).count).must_equal perfil.adjuntos.count
    end

    it 'sólo muestra los adjuntos del perfil solicitado' do
      loguearse

      autorizar do
        get :index, perfil_id: create(:perfil).id
      end

      _(assigns(:perfil)).wont_be :nil?
      _(assigns(:adjuntos)).must_be :empty?
    end

    it 'va a editar si está autorizado' do
      perfil = create(:perfil, usuario: usuario)
      adjunto = perfil.adjuntos.create attributes_for(:adjunto)

      autorizar do
        get :edit, id: adjunto, perfil_id: perfil.id
      end

      must_respond_with :success
      _(assigns(:perfil)).wont_be :nil?
      _(assigns(:adjunto)).wont_be :nil?
    end

    it 'actualizar un adjunto si está autorizado' do
      perfil = create(:perfil, usuario: usuario)
      adjunto = perfil.adjuntos.create attributes_for(:adjunto)

      autorizar do
        put :update, id: adjunto, adjunto: { notas: 'lo que se anotó' }, perfil_id: perfil.id
      end

      must_redirect_to perfil_adjuntos_path(perfil)
      _(adjunto.reload.notas).must_equal 'lo que se anotó'
    end

    it 'crea un adjunto con el usuario actual' do
      perfil = create(:perfil, usuario: usuario)

      autorizar do
        put :create, adjunto: attributes_for(:adjunto), perfil_id: perfil.id
      end

      _(assigns(:perfil).usuario).must_equal usuario
    end
  end

  describe 'sin loguearse' do
    subject { perfil.adjuntos.create attributes_for(:adjunto) }
    let(:perfil) { create :perfil, publico: true }

    before { _(@controller.current_usuario).must_be :nil? }

    it 'accede a la lista de adjuntos de un perfil público' do
      get :index, perfil_id: perfil.to_param

      must_respond_with :success
      _(assigns(:perfil)).wont_be :nil?
    end

    it 'accede a un adjunto' do
      _(subject).must_be :persisted?

      get :show, perfil_id: perfil.to_param, id: subject.to_param

      must_respond_with :success
      _(assigns(:adjunto)).wont_be :nil?
      _(assigns(:adjunto)).must_equal subject
    end

    it 'descarga a un adjunto' do
      _(subject).must_be :persisted?

      get :descargar, perfil_id: perfil.to_param, id: subject.to_param

      must_respond_with :success
    end

    it 'no accede a la lista de adjuntos de perfiles privados' do
      perfil = create :perfil, publico: false

      get :index, perfil_id: perfil.to_param

      must_redirect_to root_path
    end

    it 'no accede a adjuntos privados' do
      perfil = create :perfil, publico: false
      privado = perfil.adjuntos.create attributes_for(:adjunto)

      get :show, perfil_id: perfil.to_param, id: subject.to_param

      must_redirect_to root_path
    end

    it 'no descarga adjuntos privados' do
      perfil = create :perfil, publico: false
      privado = perfil.adjuntos.create attributes_for(:adjunto)

      get :descargar, perfil_id: perfil.to_param, id: subject.to_param

      must_redirect_to root_path
    end
  end
end
