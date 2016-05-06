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
        assigns(:analiticos).wont_be :nil?
        assigns(:analiticos).sort.must_equal perfil.analiticos.sort
      end
    end
  end
end
