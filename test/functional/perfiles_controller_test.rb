# encoding: utf-8
require './test/test_helper'

class CalicatasControllerTest < ActionController::TestCase

  setup do
    @admin = create(:usuario, :administrador)
  end

  test "debería acceder al controlador" do
    assert_instance_of CalicatasController, @controller
  end

  test "should get index" do
    sign_in @admin
    get :index
    assert_response :success
    assert_not_nil assigns(:calicatas)
  end

  test "should get new" do
    sign_in @admin
    get :new
    assert_response :success
  end

  test "should create calicata" do
    sign_in @admin

    assert_difference('Calicata.count', 1) do
      post :create, calicata: attributes_for(:calicata)
    end

    assert_redirected_to calicata_path(assigns(:calicata))
  end

  test "should show calicata" do
    sign_in @admin
    @request.env["HTTP_REFERER"] = "/calicatas/"

    get :show, id: create(:calicata).to_param

    assert_response :success
  end

  test "should get edit" do
    sign_in @admin
    get :edit, id: create(:calicata).to_param

    assert_response :success
  end

  test "should update calicata" do
    sign_in @admin
    calicata = create(:calicata)
    @request.env["HTTP_REFERER"] = "/calicatas/#{calicata.to_param}"
    put :update, id: calicata.to_param, calicata: calicata.attributes
    assert_redirected_to calicata_path(assigns(:calicata))
  end

  test "should destroy calicata" do
    sign_in @admin
    calicata = create(:calicata)
    assert_difference('Calicata.count', -1) do
      delete :destroy, id: calicata.to_param
    end

    assert_redirected_to calicatas_path
  end

  test "debería poder acceder a la lista de calicatas sin loguearse" do
    assert_nil @controller.current_usuario
    get :index
    assert_response :success
  end

  test "debería poder acceder a los datos en geoJSON sin loguearse" do
    assert_nil @controller.current_usuario
    @request.env["HTTP_REFERER"] = "/calicatas/"
    get :geo, format: :json
    assert_response :success
  end

end
