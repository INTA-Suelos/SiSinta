# encoding: utf-8
require './test/test_helper'

class CalicatasControllerTest < ActionController::TestCase

  fixtures :calicatas

  setup do
    @calicata = calicatas(:uno)
    @admin = Usuario.find_by_nombre('Administrador')
    @simple = Usuario.create  :nombre => 'simplón',
                              :email => 'roro@usuarios.com',
                              :password => 'algun password inolvidable'
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
      post :create, calicata: { fecha: @calicata.fecha, nombre: 'un nombre' }
    end

    assert_redirected_to calicata_path(assigns(:calicata))
  end

  test "should show calicata" do
    sign_in @admin
    @request.env["HTTP_REFERER"] = "/calicatas/"

    get :show, id: @calicata.to_param

    assert_response :success
  end

  test "should get edit" do
    sign_in @admin
    get :edit, id: @calicata.to_param

    assert_response :success
  end

  test "should update calicata" do
    sign_in @admin
    @request.env["HTTP_REFERER"] = "/calicatas/#{@calicata.to_param}"
    put :update, id: @calicata.to_param, calicata: @calicata.attributes
    assert_redirected_to calicata_path(assigns(:calicata))
  end

  test "should destroy calicata" do
    sign_in @admin
    assert_difference('Calicata.count', -1) do
      delete :destroy, id: @calicata.to_param
    end

    assert_redirected_to calicatas_path
  end

  test "debería loguear al usuario" do
    sign_in @simple
    assert_equal @simple, @controller.current_usuario
  end

  test "current_user debería ser igual que current_usuario" do
    sign_in @simple
    assert_not_nil @controller.current_usuario, "no hay un usuario logueado"
    assert_equal @controller.current_usuario, @controller.current_user, "devuelven diferentes cosas"
  end

  test "el usuario logueado debería ser admin" do
    sign_in @admin
    assert @controller.current_usuario.admin?, "el usuario no es admin"
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
