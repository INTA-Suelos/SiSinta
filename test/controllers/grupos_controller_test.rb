# encoding: utf-8
require './test/test_helper'

class GruposControllerTest < ActionController::TestCase
  test "autocompleta descripción" do
    termino = create(:grupo).descripcion

    get :autocomplete_grupo_descripcion, term: termino
    assert_response :success
    assert_equal  Grupo.where("descripcion like '%#{termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('value'), "debe devolver la descripción"
  end

  test "va a 'nuevo' si está autorizado" do
    loguearse

    autorizar { get :new }

    assert_response :success
  end

  test 'crea un grupo si está autorizado' do
    loguearse

    assert_difference('Grupo.count', 1) do
      autorizar do
        post :create, grupo: attributes_for(:grupo)
      end
    end

    assert_redirected_to grupo_path(assigns(:grupo))
  end

  test "va a 'editar' si está autorizado" do
    loguearse
    grupo = create(:grupo)

    autorizar do
      get :edit, id: grupo.to_param
    end

    assert_response :success
  end

  test "actualiza un grupo si está autorizado" do
    loguearse
    grupo = create(:grupo)
    params = attributes_for(:grupo)

    autorizar do
      put :update, id: grupo.to_param, grupo: params
    end

    assert_redirected_to grupo_path(assigns(:grupo))
    assert_equal grupo.id, assigns(:grupo).id
    assert_equal params[:descripcion], assigns(:grupo).descripcion
    assert_equal params[:codigo], assigns(:grupo).codigo
  end
end
