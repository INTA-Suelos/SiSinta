require 'test_helper'

class CalicatasControllerTest < ActionController::TestCase

  setup do
    @calicata = calicatas(:one)
    sign_in usuarios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calicatas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calicata" do
    assert_difference('Calicata.count') do
      post :create, calicata: @calicata.attributes
    end

    assert_redirected_to calicata_path(assigns(:calicata))
  end

  test "should show calicata" do
    get :show, id: @calicata.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @calicata.to_param
    assert_response :success
  end

  test "should update calicata" do
    put :update, id: @calicata.to_param, calicata: @calicata.attributes
    assert_redirected_to calicata_path(assigns(:calicata))
  end

  test "should destroy calicata" do
    assert_difference('Calicata.count', -1) do
      delete :destroy, id: @calicata.to_param
    end

    assert_redirected_to calicatas_path
  end
end
