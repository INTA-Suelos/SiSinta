# encoding: utf-8
require './test/test_helper'

class EquiposControllerTest < ActionController::TestCase
  test "muestra la lista de equipos si está autorizado" do
    loguearse_como 'Autorizado'
    get :index
    assert_response :success
    assert_not_nil assigns(:equipos)
  end

  test "va a 'nuevo' si está autorizado" do
    loguearse_como 'Autorizado'

    get :new
    assert_response :success
  end

  test "crea un equipo si está autorizado" do
    loguearse_como 'Autorizado'

    assert_difference('Equipo.count') do
      post :create, equipo: attributes_for(:equipo)
    end

    assert_redirected_to equipo_path(assigns(:equipo))
  end

  test "muestra un equipo si está autorizado" do
    loguearse_como 'Autorizado'

    get :show, id: create(:equipo)
    assert_response :success
  end

  test "va a 'editar' si está autorizado" do
    usuario = loguearse_como 'Autorizado'
    equipo = create(:equipo, usuario: usuario)

    get :edit, id: equipo
    assert_response :success
  end

  test "actualiza un equipo si está autorizado" do
    usuario = loguearse_como 'Autorizado'
    equipo = create(:equipo, usuario: usuario)

    put :update, id: equipo, equipo: attributes_for(:equipo)
    assert_redirected_to equipo_path(assigns(:equipo))
  end

  test "elimina un equipo si está autorizado" do
    usuario = loguearse_como 'Autorizado'
    equipo = create(:equipo, usuario: usuario)

    assert_difference('Equipo.count', -1) do
      delete :destroy, id: equipo
    end

    assert_redirected_to equipos_path
  end

  test "editar incluye tags para autocompletar" do
    usuario = loguearse_como 'Autorizado'
    get :edit, id: create(:equipo, usuario: usuario)

    assert_select '#equipo_nuevo_miembro_id'
    assert_select '#equipo_nuevo_miembro_email'
    assert_select '#equipo_nuevo_miembro_nombre'
  end
end
