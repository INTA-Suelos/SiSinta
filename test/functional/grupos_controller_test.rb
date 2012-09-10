# encoding: utf-8
require './test/test_helper'

class GruposControllerTest < ActionController::TestCase

  test "debería routear a descripcion" do
    assert_generates '/grupos/autocompletar/descripcion',
                      { controller: 'grupos',
                        action: 'autocompletar',
                        atributo: 'descripcion' }
  end

  test "debería devolver descripcion para términos parciales" do
    loguearse_como :autorizado
    @termino = 'des'
    get :autocompletar, atributo: 'descripcion', term: @termino
    assert_response :success
    assert_equal  Grupo.where("descripcion like '%#{@termino}%'").size,
                  json.size
  end

end
