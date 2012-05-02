# -*- encoding : utf-8 -*-
require 'test_helper'

class GruposControllerTest < ActionController::TestCase

  test "debería routear a descripcion" do
    assert_generates '/grupos/autocompletar/descripcion',
                      { controller: 'grupos',
                        action: 'autocompletar',
                        atributo: 'descripcion' }
  end

end
