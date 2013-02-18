# encoding: utf-8
require './test/test_helper'

class AdjuntosControllerTest < ActionController::TestCase

  setup do
    loguearse_como :autorizado
    @adjunto = create(:adjunto)
    @perfil = @adjunto.perfil
    @adjuntos = Array.wrap(@adjunto)
    @request.env["HTTP_REFERER"] = "/perfiles/#{@perfil.to_param}/adjuntos"
  end

  test "debería mostrar los adjuntos del perfil" do
    get :index, perfil_id: @perfil.id
    assert_response :success
    assert_not_nil assigns(:perfil), "No asigna @perfil"
    assert_not_nil assigns(:adjuntos), "No asigna @adjuntos"
    assert_equal @adjuntos.sort, assigns(:adjuntos).sort
  end

  test "debería ir a 'editar' si está autorizado" do
    get :edit, id: @adjunto.to_param, perfil_id: @perfil.id
    assert_response :success
    assert_not_nil assigns(:perfil), "No asigna @perfil"
    assert_not_nil assigns(:adjunto), "No asigna @adjunto"
  end

  test "debería actualizar un adjunto si está autorizado" do
    put :update, id: @adjunto.to_param, adjuntos: attributes_for(:adjunto), perfil_id: @perfil.id

    assert_redirected_to perfil_adjuntos_path(@perfil)
  end

end
