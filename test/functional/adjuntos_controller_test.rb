# encoding: utf-8
require './test/test_helper'

class AdjuntosControllerTest < ActionController::TestCase

  setup do
    loguearse_como 'Autorizado'
    @adjunto = create(:adjunto)
    @perfil = @adjunto.perfil
    @adjuntos = Array.wrap(@adjunto)
    @request.env["HTTP_REFERER"] = "/perfiles/#{@perfil.to_param}/adjuntos"
  end

  test "rutea a index" do
    assert_routing({
      path: "/perfiles/#{@perfil.to_param}/adjuntos",
      method: :get
    },{
      controller: 'adjuntos', action: 'index',
      perfil_id: @perfil.to_param
    })
  end

  test "rutea a show" do
    assert_routing({
      path: "/perfiles/#{@perfil.to_param}/adjuntos/#{@adjunto.to_param}",
      method: :get
    },{
      controller: 'adjuntos', action: 'show',
      perfil_id: @perfil.to_param, id: @adjunto.to_param
    })
  end

  test "rutea a descargar" do
    assert_routing({
      path: "/perfiles/#{@perfil.to_param}/adjuntos/#{@adjunto.to_param}/descargar",
      method: :get
    },{
      controller: 'adjuntos', action: 'descargar',
      perfil_id: @perfil.to_param, id: @adjunto.to_param
    })
  end

  test "muestra los adjuntos del perfil" do
    get :index, perfil_id: @perfil.id
    assert_response :success
    assert_not_nil assigns(:perfil), "No asigna @perfil"
    assert_not_nil assigns(:adjuntos), "No asigna @adjuntos"
    assert_equal @adjuntos.sort, assigns(:adjuntos).sort
  end

  test "sólo muestra los adjuntos del perfil solicitado" do
    get :index, perfil_id: create(:perfil).id
    assert_not_nil assigns(:perfil), "No asigna @perfil"
    assert assigns(:adjuntos).empty?, "Asigna @adjuntos"
  end

  test "ir a 'editar' si está autorizado" do
    get :edit, id: @adjunto.to_param, perfil_id: @perfil.id
    assert_response :success
    assert_not_nil assigns(:perfil), "No asigna @perfil"
    assert_not_nil assigns(:adjunto), "No asigna @adjunto"
  end

  test "actualizar un adjunto si está autorizado" do
    put :update, id: @adjunto.to_param, adjuntos: attributes_for(:adjunto), perfil_id: @perfil.id

    assert_redirected_to perfil_adjuntos_path(@perfil)
  end

end
