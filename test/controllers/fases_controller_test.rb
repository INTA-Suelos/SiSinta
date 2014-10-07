# encoding: utf-8
require './test/test_helper'

class FasesControllerTest < ActionController::TestCase
  test 'autocompleta nombre' do
    termino = create(:fase).nombre
    get :autocomplete_fase_nombre, term: termino
    assert_response :success
    assert_equal  Fase.where("nombre like '%#{termino}%'").size,
                  json.size

    assert json.first.include?('id'), 'debe devolver el id'
    assert json.first.include?('label'), 'debe devolver el label'
    assert json.first.include?('value'), 'debe devolver el nombre'
  end

  test 'va a nueva si está autorizado' do
    loguearse

    autorizar { get :new }

    assert_response :success
  end

  test 'crea una fase si está autorizado' do
    loguearse

    assert_difference('Fase.count', 1) do
      autorizar do
        post :create, fase: attributes_for(:fase)
      end
    end

    assert_redirected_to fase_path(assigns(:fase))
  end

  test 'va a editar si está autorizado' do
    loguearse

    autorizar do
      get :edit, id: create(:fase).to_param
    end

    assert_response :success
  end

  test 'actualiza una fase si está autorizado' do
    loguearse
    fase = create(:fase)
    params = attributes_for(:fase)

    autorizar do
      put :update, id: fase.to_param, fase: params
    end

    assert_redirected_to fase_path(assigns(:fase))
    assert_equal fase.id, assigns(:fase).id
    assert_equal params[:nombre], assigns(:fase).nombre
    assert_equal params[:codigo], assigns(:fase).codigo
  end
end
