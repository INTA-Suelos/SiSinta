# encoding: utf-8
require 'test_helper'

class FasesControllerTest < ActionController::TestCase

  fixtures :fases

  setup do
    loguearse_con_permisos
  end

  test "debería routear a nombre" do
    assert_generates '/fases/autocompletar/nombre',
                      { controller: 'fases',
                        action: 'autocompletar',
                        atributo: 'nombre' }
  end

  test "debería devolver nombre para términos parciales" do
    @termino = 'a'
    get :autocompletar, atributo: 'nombre', term: @termino
    assert_response :success
    assert_equal  Fase.where("nombre like '%#{@termino}%'").size,
                  json.size
  end

end
