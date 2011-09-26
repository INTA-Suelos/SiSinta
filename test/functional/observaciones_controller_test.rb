require 'test_helper'

class ObservacionesControllerTest < ActionController::TestCase
  setup do
    @observacion = observaciones(:one)
    session[:id] = usuarios(:one).id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:observaciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create observacion" do
    assert_difference('Observacion.count') do
      post :create, observacion: @observacion.attributes
    end

    assert_redirected_to observacion_path(assigns(:observacion))
  end

  test "should show observacion" do
    get :show, id: @observacion.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @observacion.to_param
    assert_response :success
  end

  test "should update observacion" do
    put :update, id: @observacion.to_param, observacion: @observacion.attributes
    assert_redirected_to observacion_path(assigns(:observacion))
  end

  test "should destroy observacion" do
    assert_difference('Observacion.count', -1) do
      delete :destroy, id: @observacion.to_param
    end

    assert_redirected_to observaciones_path
  end
end
