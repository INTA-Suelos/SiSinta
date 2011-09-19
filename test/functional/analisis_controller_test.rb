require 'test_helper'

class AnalisisControllerTest < ActionController::TestCase
  setup do
    @analisis = analisis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analisis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create analisis" do
    assert_difference('Analisis.count') do
      post :create, analisis: @analisis.attributes
    end

    assert_redirected_to analisis_path(assigns(:analisis))
  end

  test "should show analisis" do
    get :show, id: @analisis.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @analisis.to_param
    assert_response :success
  end

  test "should update analisis" do
    put :update, id: @analisis.to_param, analisis: @analisis.attributes
    assert_redirected_to analisis_path(assigns(:analisis))
  end

  test "should destroy analisis" do
    assert_difference('Analisis.count', -1) do
      delete :destroy, id: @analisis.to_param
    end

    assert_redirected_to analisis_index_path
  end
end
