# encoding: utf-8
require './test/test_helper'

class AnalisisControllerTest < ActionController::TestCase

  setup do
    loguearse_como :autorizado
    @perfil = create(:perfil)
    5.times do
      @perfil.analisis.create(attributes_for(:analisis))
    end
    @request.env["HTTP_REFERER"] = "/perfiles/#{@perfil.to_param}/analisis"
  end

  test "debería ir al índice de análisis si está autorizado" do
    get :index, perfil_id: @perfil.id
    assert_response :success
    perfil = assigns(:perfil)
    analisis = assigns(:analisis)
    assert_not_nil perfil, "No asigna el perfil en el index"
    assert_not_nil analisis, "No asigna los análisis en el index"
    assert_equal analisis.sort, perfil.analisis.sort
  end

  test "debería ir a 'editar' si está autorizado" do
    get :edit, id: @analisis.to_param, perfil_id: @perfil.id
    assert_response :success
    assert_not_nil assigns(:perfil), "No asigna el perfil en 'editar'"
    assert_not_nil assigns(:analisis), "No asigna los análisis en 'editar'"
  end

  test "debería actualizar los análisis" do
    put :update, perfil_id: @perfil.id, perfil: attributes_for(:perfil)

    # FIXME Está redirigiendo pero el test falla :|
    assert_redirected_to perfil_analisis_index_path(@perfil)
  end

end
