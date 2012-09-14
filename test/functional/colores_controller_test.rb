# encoding: utf-8
require './test/test_helper'

class ColoresControllerTest < ActionController::TestCase

  test "debería routear a hvc" do
    assert_generates '/colores/autocompletar/hvc',
                      { controller: 'colores',
                        action: 'autocompletar',
                        atributo: 'hvc' }
  end

  test "debería routear a rgb" do
    assert_generates '/colores/autocompletar/rgb',
                      { controller: 'colores',
                        action: 'autocompletar',
                        atributo: 'rgb' }
  end

  test "debería devolver hvc para términos parciales" do
    @termino = '10'
    get :autocompletar, atributo: 'hvc', term: @termino
    assert_response :success
    assert_equal  Color.where("hvc like '%#{@termino}%'").size,
                  json.size
  end

  test "debería devolver rgb para términos parciales" do
    @termino = '10'
    get :autocompletar, atributo: 'rgb', term: @termino
    assert_response :success
    assert_equal  Color.where("rgb like '%#{@termino}%'").size,
                  json.size
  end
end
