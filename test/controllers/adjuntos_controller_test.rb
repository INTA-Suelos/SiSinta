require 'test_helper'

describe AdjuntosController do
  let(:usuario) { loguearse }

  it 'muestra los adjuntos del perfil' do
    perfil = create(:perfil, usuario: usuario)
    3.times do
      create(:adjunto, perfil: perfil)
    end

    autorizar do
      get :index, perfil_id: perfil.id
    end

    must_respond_with :success
    assigns(:perfil).wont_be :nil?
    assigns(:adjuntos).wont_be :nil?
    assigns(:adjuntos).count.must_equal perfil.adjuntos.count
  end

  it 'sólo muestra los adjuntos del perfil solicitado' do
    loguearse

    autorizar do
      get :index, perfil_id: create(:perfil).id
    end

    assigns(:perfil).wont_be :nil?
    assigns(:adjuntos).must_be :empty?
  end

  it 'va a editar si está autorizado' do
    perfil = create(:perfil, usuario: usuario)
    adjunto = perfil.adjuntos.create attributes_for(:adjunto)

    autorizar do
      get :edit, id: adjunto, perfil_id: perfil.id
    end

    must_respond_with :success
    assigns(:perfil).wont_be :nil?
    assigns(:adjunto).wont_be :nil?
  end

  it 'actualizar un adjunto si está autorizado' do
    perfil = create(:perfil, usuario: usuario)
    adjunto = perfil.adjuntos.create attributes_for(:adjunto)

    autorizar do
      put :update, id: adjunto, adjunto: { notas: 'lo que se anotó' }, perfil_id: perfil.id
    end

    must_redirect_to perfil_adjuntos_path(perfil)
    adjunto.reload.notas.must_equal 'lo que se anotó'
  end

  it 'crea un adjunto con el usuario actual' do
    perfil = create(:perfil, usuario: usuario)

    autorizar do
      put :create, adjunto: attributes_for(:adjunto), perfil_id: perfil.id
    end

    assigns(:perfil).usuario.must_equal usuario
  end
end
