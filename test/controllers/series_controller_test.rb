# encoding: utf-8
require './test/test_helper'

class SeriesControllerTest < ActionController::TestCase
  test "accede a la lista de series sin loguearse" do
    assert_nil @controller.current_usuario
    get :index
    assert_response :success
  end

  test "va a 'nueva' si está autorizado" do
    loguearse

    autorizar { get :new }

    assert_response :success
  end

  test "crea una serie si está autorizado" do
    loguearse

    assert_difference('Serie.count') do
      autorizar do
        post :create, serie: attributes_for(:serie)
      end
    end

    assert_redirected_to serie_path(assigns(:serie))
  end

  test "muestra una serie sin loguearse" do
    get :show, id: create(:serie)
    assert_response :success
  end

  test "va a 'editar' si está autorizado" do
    usuario = loguearse

    autorizar do
      get :edit, id: create(:serie, usuario: usuario)
    end

    assert_response :success
  end

  test "actualiza una serie si está autorizado" do
    usuario = loguearse
    serie = create(:serie, usuario: usuario)

    autorizar do
      put :update, id: serie, serie: {
        nombre: 'de Fibonacci', simbolo: 'fi', descripcion: 'Larga'
      }
    end

    assert_redirected_to serie_path(assigns(:serie))
    assert_equal serie.id, assigns(:serie).id
    assert_equal 'de Fibonacci', assigns(:serie).nombre
    assert_equal 'fi', assigns(:serie).simbolo
    assert_equal 'Larga', assigns(:serie).descripcion
  end

  test "elimina una serie si está autorizado" do
    usuario = loguearse
    serie = create(:serie, usuario: usuario)

    assert_difference('Serie.count', -1) do
      autorizar do
        delete :destroy, id: serie
      end
    end

    assert_redirected_to series_path
  end

  test "devuelve nombre para términos parciales" do
    termino = create(:serie).nombre

    get :autocomplete_serie_nombre, term: termino
    assert_response :success
    assert_equal  Serie.where("nombre like '%#{termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('value'), "debe devolver el nombre"
    assert json.first.include?('simbolo'), "debe incluir el simbolo"
  end

  test "devuelve símbolo para términos parciales" do
    termino = create(:serie).simbolo

    get :autocomplete_serie_simbolo, term: termino
    assert_response :success
    assert_equal  Serie.where("simbolo like '%#{termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('value'), "debe devolver el simbolo"
    assert json.first.include?('nombre'), "debe incluir el nombre"
  end
end
