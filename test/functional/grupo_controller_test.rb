# -*- encoding : utf-8 -*-
require 'test_helper'

class GruposControllerTest < ActionController::TestCase

  test "debería routear a descripcion" do
    assert_generates '/grupos/ajax/descripcion', {  controller: 'grupos',
                                                    action: 'ajax',
                                                    atributo: 'descripcion' }
  end

end
