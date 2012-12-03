# encoding: utf-8
require './test/test_helper'

class FasesControllerTest < ActionController::TestCase

  test "debería routear a nombre" do
    assert_generates '/fases/autocompletar/nombre',
                      { controller: 'fases',
                        action: 'autocompletar',
                        atributo: 'nombre' }
  end

  test "debería devolver nombre para términos parciales" do
    loguearse_como I18n.t('roles.data_entry')
    @termino = create(:fase).nombre
    get :autocompletar, atributo: 'nombre', term: @termino
    assert_response :success
    assert_equal  Fase.where("nombre like '%#{@termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('nombre'), "debe devolver el nombre"
  end

end
