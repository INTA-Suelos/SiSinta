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
end
