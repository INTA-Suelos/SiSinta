# encoding: utf-8
require './test/test_helper'

class AnaliticosControllerTest < ActionController::TestCase
  test "va al índice de analíticos si está autorizado" do
    loguearse_como 'Autorizado'

    get :index, perfil_id: create(:perfil).to_param
    assert_response :success
    perfil = assigns(:perfil)
    analiticos = assigns(:analiticos)
    assert_not_nil perfil, "No asigna el perfil en el index"
    assert_not_nil analiticos, "No asigna los analíticos en el index"
    assert_equal analiticos.sort, perfil.analiticos.sort
  end
end
