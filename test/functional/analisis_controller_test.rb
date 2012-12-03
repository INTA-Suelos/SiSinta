# encoding: utf-8
require './test/test_helper'

class AnalisisControllerTest < ActionController::TestCase

  setup do
    loguearse_como I18n.t('roles.data_entry')
    @analisis = create(:analisis)
    @perfil = @analisis.perfil
    @request.env["HTTP_REFERER"] = "/perfiles/#{@perfil.to_param}/analisis"
  end

  test "should get index" do
    get :index, perfil_id: @perfil.id
    assert_response :success
    perfil = assigns(:perfil)
    assert_not_nil perfil
    assert_not_nil perfil.analisis
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
