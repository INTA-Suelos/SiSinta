# -*- encoding : utf-8 -*-
require 'test_helper'

class FasesControllerTest < ActionController::TestCase

  test "debería routear a nombre" do
    assert_generates '/fases/autocompletar/nombre',
                      { controller: 'fases',
                        action: 'autocompletar',
                        atributo: 'nombre' }
  end

end
