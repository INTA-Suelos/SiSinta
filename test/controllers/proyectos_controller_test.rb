# encoding: utf-8
require './test/test_helper'

class ProyectosControllerTest < ActionController::TestCase
  test "accede a la lista de proyectos sin loguearse" do
    assert_nil @controller.current_usuario
    get :index
    assert_response :success
  end

  test "va a 'nuevo' si está autorizado" do
    loguearse_como 'Autorizado'

    get :new
    assert_response :success
  end

  test "crea un proyecto si está autorizado" do
    loguearse_como 'Autorizado'

    assert_difference('Proyecto.count') do
      post :create, proyecto: attributes_for(:proyecto)
    end

    assert_redirected_to proyecto_path(assigns(:proyecto))
  end

  test "muestra un proyecto sin loguearse" do
    get :show, id: create(:proyecto)
    assert_response :success
  end

  test "va a 'editar' si está autorizado" do
    usuario = loguearse_como 'Autorizado'

    get :edit, id: create(:proyecto, usuario: usuario)
    assert_response :success
  end

  test "actualiza un proyecto si está autorizado" do
    usuario = loguearse_como 'Autorizado'
    proyecto = create(:proyecto, usuario: usuario)

    put :update, id: proyecto, proyecto: { nombre: 'Flaco Pantera 3' }
    assert_redirected_to proyecto_path(assigns(:proyecto))
    assert_equal 'Flaco Pantera 3', assigns(:proyecto).nombre
  end

  test "elimina un proyecto si está autorizado" do
    usuario = loguearse_como 'Autorizado'
    proyecto = create(:proyecto, usuario: usuario)

    assert_difference('Proyecto.count', -1) do
      delete :destroy, id: proyecto
    end

    assert_redirected_to proyectos_path
  end
end
