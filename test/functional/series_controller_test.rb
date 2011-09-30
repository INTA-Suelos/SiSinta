require 'test_helper'

class SeriesControllerTest < ActionController::TestCase
  setup do
    @series = series(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:series)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create series" do
    assert_difference('Serie.count') do
      post :create, series: @series.attributes
    end

    assert_redirected_to series_path(assigns(:series))
  end

  test "should show series" do
    get :show, id: @series.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @series.to_param
    assert_response :success
  end

  test "should update series" do
    put :update, id: @series.to_param, series: @series.attributes
    assert_redirected_to series_path(assigns(:series))
  end

  test "should destroy series" do
    assert_difference('Serie.count', -1) do
      delete :destroy, id: @series.to_param
    end

    assert_redirected_to series_path
  end
end
