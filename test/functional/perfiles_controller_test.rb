# encoding: utf-8
require './test/test_helper'

class PerfilesControllerTest < ActionController::TestCase

  setup do
    @admin = create(:usuario, :administrador)
  end

  test "debería acceder al controlador" do
    assert_instance_of PerfilesController, @controller
  end

  test "should get index" do
    sign_in @admin
    get :index
    assert_response :success
    assert_not_nil assigns(:perfiles)
  end

  test "should get new" do
    sign_in @admin
    get :new
    assert_response :success
  end

  test "should create perfil" do
    sign_in @admin

    assert_difference('Perfil.count', 1) do
      post :create, perfil: attributes_for(:perfil)
    end

    assert_redirected_to perfil_path(assigns(:perfil))
  end

  test "should show perfil" do
    sign_in @admin
    @request.env["HTTP_REFERER"] = "/perfiles/"

    get :show, id: create(:perfil).to_param

    assert_response :success
  end

  test "should get edit" do
    sign_in @admin
    get :edit, id: create(:perfil).to_param

    assert_response :success
  end

  test "should update perfil" do
    sign_in @admin
    perfil = create(:perfil)
    @request.env["HTTP_REFERER"] = "/perfiles/#{perfil.to_param}"
    put :update, id: perfil.to_param, perfil: perfil.attributes
    assert_redirected_to perfil_path(assigns(:perfil))
  end

  test "should destroy perfil" do
    sign_in @admin
    perfil = create(:perfil)
    assert_difference('Perfil.count', -1) do
      delete :destroy, id: perfil.to_param
    end

    assert_redirected_to perfiles_path
  end

  test "debería poder acceder a la lista de perfiles sin loguearse" do
    assert_nil @controller.current_usuario
    get :index
    assert_response :success
  end

  test "debería poder acceder a los datos en geoJSON sin loguearse" do
    assert_nil @controller.current_usuario
    @request.env["HTTP_REFERER"] = "/perfiles/"
    get :geo, format: :json
    assert_response :success
  end

end
