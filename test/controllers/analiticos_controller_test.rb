require './test/test_helper'

describe AnaliticosController do
  describe 'autorizado' do
    let(:perfil) { create(:perfil) }

    before do
      create :ficha, :default
      loguearse_como 'Autorizado'
    end

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

        assigns(:perfil).wont_be :nil?
        assigns(:analiticos).wont_be :empty?
      end

      it 'asigna los analíticos en el mismo orden que los horizontes' do
        perfil = create(:perfil_completo, con_horizontes: 0)
        perfil.horizontes.create profundidad_inferior: 1,
          analitico_attributes: { profundidad_muestra: 3 }
        perfil.horizontes.create profundidad_inferior: 2,
          analitico_attributes: { profundidad_muestra: 2 }
        perfil.horizontes.create profundidad_inferior: 3,
          analitico_attributes: { profundidad_muestra: 1 }

        get :index, perfil_id: perfil.to_param

        assigns(:analiticos).must_equal perfil.analiticos
        assigns(:analiticos).collect(&:horizonte_id).must_equal perfil.horizontes.ids
      end
    end
  end
end
