# encoding: utf-8
require './test/test_helper'

class AnalisisControllerTest < ActionController::TestCase

  fixtures :analisis, :calicatas

  setup do
    @analisis = analisis(:uno)
    @calicata = calicatas(:valida)
    sign_in Usuario.find_by_nombre('Administrador')
    @request.env["HTTP_REFERER"] = "/calicatas/#{@calicata.to_param}/analisis"
  end

  test "should get index" do
    get :index, calicata_id: @calicata.id
    assert_response :success
    assert_not_nil assigns(:analisis)
  end

  test "should get edit" do
    get :edit, id: @analisis.to_param, calicata_id: @calicata.id
    assert_response :success
  end

  test "should update analisis" do
    put :update, id: @analisis.to_param, analisis: @analisis.attributes, calicata_id: @calicata.id
    assert_redirected_to calicata_analisis_index_path(@calicata)
  end

end
