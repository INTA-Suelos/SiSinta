# encoding: utf-8
require './test/test_helper'

class ColoresControllerTest < ActionController::TestCase

  test "autocompleta hvc" do
    termino = create(:color).hvc

    get :autocomplete_color_hvc, term: termino
    assert_response :success
    assert_equal  Color.where("hvc like '%#{termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('value'), "debe devolver el hvc"
  end

  test "autocompleta rgb" do
    termino = create(:color).rgb

    get :autocomplete_color_rgb, term: termino
    assert_response :success
    assert_equal  Color.where("rgb like '%#{termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('value'), "debe devolver el rgb"
  end
end
