require 'test_helper'

describe AnaliticosController do
  let(:perfil) { create(:perfil) }

  before { create :ficha, :default }

  describe 'no logueado' do
    it 'muestra los analíticos si el perfil es público' do
      publico = create :perfil, publico: true, horizontes: [create(:horizonte)]

      get :index, perfil_id: publico.to_param

      must_respond_with :success
    end

    it 'redirije al inicio si el perfil es privado' do
      privado = create :perfil, horizontes: [create(:horizonte)]

      get :index, perfil_id: privado.to_param

      must_redirect_to root_path
    end
  end

  describe 'no autorizado' do
    before { loguearse }

    it 'redirije al inicio si no hay permisos' do
      privado = create :perfil, horizontes: [create(:horizonte)]

      get :index, perfil_id: privado.to_param

      must_redirect_to root_path
    end
  end

  describe 'autorizado' do
    before { loguearse_como 'Autorizado' }

    it 'redirije al perfil si no hay horizontes' do
      get :index, perfil_id: perfil.to_param

      must_redirect_to perfil
    end

    describe 'si hay horizontes' do
      let(:perfil) { create(:perfil_completo) }

      it 'va al índice' do
        get :index, perfil_id: perfil.to_param

        must_respond_with :success
      end

      it 'asigna los objetos necesarios' do
        get :index, perfil_id: perfil.to_param

        _(assigns(:perfil)).wont_be :nil?
        _(assigns(:analiticos)).wont_be :empty?
      end

      it 'asigna los analíticos en el mismo orden que los horizontes' do
        perfil = create :perfil
        perfil.horizontes.create profundidad_superior: 1,
          analitico_attributes: { profundidad_muestra: 3 }
        perfil.horizontes.create profundidad_superior: 2,
          analitico_attributes: { profundidad_muestra: 2 }
        perfil.horizontes.create profundidad_superior: 3,
          analitico_attributes: { profundidad_muestra: 1 }

        get :index, perfil_id: perfil.to_param

        _(assigns(:analiticos)).must_equal perfil.analiticos
        _(assigns(:analiticos).collect(&:horizonte_id)).must_equal perfil.horizontes.ids
      end
    end
  end
end
