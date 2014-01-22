# encoding: utf-8
require './test/test_helper'

class FasesControllerTest < ActionController::TestCase

  test "autocompleta nombre" do
    termino = create(:fase).nombre
    get :autocomplete_fase_nombre, term: termino
    assert_response :success
    assert_equal  Fase.where("nombre like '%#{termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('value'), "debe devolver el nombre"
  end

end
