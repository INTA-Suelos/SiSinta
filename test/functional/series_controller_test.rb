# encoding: utf-8
require './test/test_helper'

class SeriesControllerTest < ActionController::TestCase

  test "debería devolver nombre para términos parciales" do
    loguearse_como :autorizado
    termino = create(:serie).nombre

    get :autocompletar, atributo: 'nombre', term: termino
    assert_response :success
    assert_equal  Serie.where("nombre like '%#{termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('nombre'), "debe devolver el nombre"
  end

  test "debería devolver símbolo para términos parciales" do
    loguearse_como :autorizado
    termino = create(:serie).simbolo

    get :autocompletar, atributo: 'simbolo', term: termino
    assert_response :success
    assert_equal  Serie.where("simbolo like '%#{termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('simbolo'), "debe devolver el simbolo"
  end

end
