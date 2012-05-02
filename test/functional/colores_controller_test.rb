# -*- encoding : utf-8 -*-
require 'test_helper'

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

end
