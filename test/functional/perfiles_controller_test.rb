# encoding: utf-8
require './test/test_helper'

class PerfilesControllerTest < ActionController::TestCase

  test "debería acceder al controlador" do
    assert_instance_of PerfilesController, @controller
  end

  test "debería ir a 'nuevo' si está autorizado" do
    loguearse_como I18n.t('roles.data_entry')

    get :new
    assert_response :success
  end

  test "debería crear un perfil si está autorizado" do
    loguearse_como I18n.t('roles.data_entry')

    assert_difference('Perfil.count', 1) do
      post :create, perfil: attributes_for(:perfil)
    end

    assert_redirected_to perfil_path(assigns(:perfil))
  end

  test "debería mostrar un perfil si está autorizado" do
    loguearse_como I18n.t('roles.data_entry')

    @request.env["HTTP_REFERER"] = "/perfiles/"

    get :show, id: create(:perfil).to_param

    assert_response :success
  end

  test "debería ir a 'editar' si está autorizado" do
    loguearse_como I18n.t('roles.data_entry')

    get :edit, id: create(:perfil).to_param
    assert_response :success
  end

  test "debería actualizar un perfil si está autorizado" do
    loguearse_como I18n.t('roles.data_entry')

    perfil = create(:perfil)
    @request.env["HTTP_REFERER"] = "/perfiles/#{perfil.to_param}"
    put :update, id: perfil.to_param, perfil: attributes_for(:perfil)
    assert_redirected_to perfil_path(assigns(:perfil))
  end

  test "debería eliminar un perfil si está autorizado" do
    loguearse_como I18n.t('roles.data_entry')

    perfil = create(:perfil)
    assert_difference('Perfil.count', -1) do
      delete :destroy, id: perfil.to_param
    end

    assert_redirected_to perfiles_path
  end

  test "debería poder acceder a la lista de perfiles sin loguearse" do
    assert_nil @controller.current_usuario
    get :index
    assert_response :success
  end

  test "debería poder acceder a los datos en geoJSON sin loguearse" do
    assert_nil @controller.current_usuario
    @request.env["HTTP_REFERER"] = "/perfiles/"
    get :geo, format: :json
    assert_response :success
  end

  test "debería devolver nombre para términos parciales" do
    loguearse_como I18n.t('roles.data_entry')
    @termino = create(:perfil).nombre

    get :autocompletar, atributo: 'nombre', term: @termino
    assert_response :success
    assert_equal  Perfil.where("nombre like '%#{@termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('nombre'), "debe devolver el nombre"
  end

  test "debería devolver numero para términos parciales" do
    loguearse_como I18n.t('roles.data_entry')
    @termino = create(:perfil).numero

    get :autocompletar, atributo: 'numero', term: @termino
    assert_response :success
    assert_equal  Perfil.where("numero like '%#{@termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('numero'), "debe devolver el número"
  end

end
