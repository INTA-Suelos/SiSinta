# -*- encoding : utf-8 -*-
require 'test_helper'

class AnalisisControllerTest < ActionController::TestCase
  setup do
    @analisis = analisis(:uno)
    @calicata = @analisis.calicata
  end

  test "should get index" do
    get :index, calicata_id: @calicata.id
    assert_response :success
    assert_not_nil assigns(:analisis)
  end

  test "should show analisis" do
    get :show, id: @analisis.to_param, calicata_id: @calicata.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @analisis.to_param, calicata_id: @calicata.id
    assert_response :success
  end

  test "should update analisis" do
    put :update, id: @analisis.to_param, analisis: @analisis.attributes, calicata_id: @calicata.id
    assert_redirected_to calicata_analisis_path(@calicata, assigns(:analisis))
  end

  test "should destroy analisis" do
    assert_difference('Analisis.count', -1) do
      delete :destroy, id: @analisis.to_param, calicata_id: @calicata.id
    end

    assert_redirected_to calicata_analisis_index_path
  end
end
