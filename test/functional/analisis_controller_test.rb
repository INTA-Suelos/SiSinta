# encoding: utf-8
require './test/test_helper'

class AnalisisControllerTest < ActionController::TestCase

  setup do
    loguearse_como :autorizado
    @analisis = create(:analisis)
    @perfil = @analisis.perfil
    @request.env["HTTP_REFERER"] = "/perfiles/#{@perfil.to_param}/analisis"
  end

  test "debería ir al índice de análisis si está autorizado" do
    get :index, perfil_id: @perfil.id
    assert_response :success
    perfil = assigns(:perfil)
    analisis = assigns(:analisis)
    assert_not_nil perfil
    assert_equal analisis.all.sort, perfil.analisis.sort
  end

  test "debería ir a 'editar' si está autorizado" do
    get :edit, id: @analisis.to_param, perfil_id: @perfil.id
    assert_response :success
    assert_not_nil assigns(:perfil)
    assert_not_nil assigns(:analisis)
  end

  test "debería actualizar los análisis" do
    put :update, id: @analisis.to_param, analisis: @analisis.attributes, perfil_id: @perfil.id
    assert_not_nil assigns(:perfil)
    assert_not_nil assigns(:analisis)

    assert_redirected_to perfil_analisis_index_path(@perfil)
  end

end
