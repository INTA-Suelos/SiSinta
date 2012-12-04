# encoding: utf-8
require './test/test_helper'

class ProyectosControllerTest < ActionController::TestCase
  setup do
    @proyecto = create(:proyecto)
    @request.env["HTTP_REFERER"] = "/proyectos/"
  end

  test "debería ir al index sin loguearse" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proyectos)
  end

  test "debería ir a 'nuevo' si está autorizado" do
    loguearse_como :autorizado

    get :new
    assert_response :success
  end

  test "debería crear un proyecto si está autorizado" do
    loguearse_como :autorizado

    assert_difference('Proyecto.count') do
      post :create, proyecto: attributes_for(:proyecto)
    end

    assert_redirected_to proyecto_path(assigns(:proyecto))
  end

  test "debería mostrar un proyecto sin loguearse" do
    get :show, id: @proyecto
    assert_response :success
  end

  test "debería ir a 'editar' si está autorizado" do
    loguearse_como :autorizado

    get :edit, id: @proyecto
    assert_response :success
  end

  test "debería actualizar un proyecto si está autorizado" do
    loguearse_como :autorizado

    put :update, id: @proyecto, proyecto: attributes_for(:proyecto)
    assert_redirected_to proyecto_path(assigns(:proyecto))
  end

  test "debería eliminar un proyecto si está autorizado" do
    loguearse_como :autorizado

    assert_difference('Proyecto.count', -1) do
      delete :destroy, id: @proyecto
    end

    assert_redirected_to proyectos_path
  end

end
