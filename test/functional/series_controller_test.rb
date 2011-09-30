require 'test_helper'

class SeriesControllerTest < ActionController::TestCase
  setup do
    @serie = series(:one)
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

  test "should create serie" do
    assert_difference('Serie.count') do
      post :create, serie: @serie.attributes
    end

    assert_redirected_to serie_path(assigns(:serie))
  end

  test "should show serie" do
    get :show, id: @serie.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @serie.to_param
    assert_response :success
  end

  test "should update series" do
    put :update, id: @serie.to_param, serie: @serie.attributes
    assert_redirected_to serie_path(assigns(:serie))
  end

  test "should destroy series" do
    assert_difference('Serie.count', -1) do
      delete :destroy, id: @serie.to_param
    end

    assert_redirected_to series_path
  end
end
