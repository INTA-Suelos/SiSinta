# encoding: utf-8
require './test/test_helper'

class EquiposControllerTest < ActionController::TestCase

  setup do
    @request.env["HTTP_REFERER"] = "/equipos/"
  end

  test "debería ir al index si está autorizado" do
    loguearse_como :autorizado
    get :index
    assert_response :success
    assert_not_nil assigns(:equipos)
  end

  test "debería ir a 'nuevo' si está autorizado" do
    loguearse_como :autorizado

    get :new
    assert_response :success
  end

  test "debería crear un equipo si está autorizado" do
    loguearse_como :autorizado

    assert_difference('Equipo.count') do
      post :create, equipo: attributes_for(:equipo)
    end

    assert_redirected_to equipo_path(assigns(:equipo))
  end

  test "debería mostrar un equipo si está autorizado" do
    loguearse_como :autorizado

    get :show, id: create(:equipo).to_param
    assert_response :success
  end

  test "debería ir a 'editar' si está autorizado" do
    loguearse_como :autorizado

    get :edit, id: create(:equipo).to_param
    assert_response :success
  end

  test "debería actualizar un equipo si está autorizado" do
    loguearse_como :autorizado

    put :update, id: create(:equipo).to_param, equipo: attributes_for(:equipo)
    assert_redirected_to equipo_path(assigns(:equipo))
  end

  test "debería eliminar un equipo si está autorizado" do
    loguearse_como :autorizado

    equipo = create(:equipo)
    assert_difference('Equipo.count', -1) do
      delete :destroy, id: equipo.to_param
    end

    assert_redirected_to equipos_path
  end
end
