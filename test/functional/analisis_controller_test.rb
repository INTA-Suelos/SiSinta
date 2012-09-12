# encoding: utf-8
require './test/test_helper'

class AnalisisControllerTest < ActionController::TestCase

  setup do
    @analisis = create(:analisis)
    @perfil = create(:perfil)
    @admin = create(:usuario, :administrador)
    sign_in @admin
    @request.env["HTTP_REFERER"] = "/perfiles/#{@perfil.to_param}/analisis"
  end

  test "should get index" do
    get :index, perfil_id: @perfil.id
    assert_response :success
    assert_not_nil assigns(:analisis)
  end

  test "should get edit" do
    get :edit, id: @analisis.to_param, perfil_id: @perfil.id
    assert_response :success
  end

  test "should update analisis" do
    put :update, id: @analisis.to_param, analisis: @analisis.attributes, perfil_id: @perfil.id
    assert_redirected_to perfil_analisis_index_path(@perfil)
  end

end
