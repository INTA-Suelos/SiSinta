require 'test_helper'

class UsuariosControllerTest < ActionController::TestCase
  setup do
    @usuario = usuarios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usuarios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usuario" do
    assert_difference('Usuario.count') do
      post :create, usuario: @usuario.attributes
    end

    assert_redirected_to usuario_path(assigns(:usuario))
  end

  test "should show usuario" do
    get :show, id: @usuario.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usuario.to_param
    assert_response :success
  end

  test "should update usuario" do
    put :update, id: @usuario.to_param, usuario: @usuario.attributes
    assert_redirected_to usuario_path(assigns(:usuario))
  end

  test "should destroy usuario" do
    assert_difference('Usuario.count', -1) do
      delete :destroy, id: @usuario.to_param
    end

    assert_redirected_to usuarios_path
  end
end
