# -*- encoding : utf-8 -*-
require 'test_helper'

class FasesControllerTest < ActionController::TestCase

  test "debería routear a nombre" do
    assert_generates '/fases/ajax/nombre', {  controller: 'fases',
                                              action: 'ajax',
                                              atributo: 'nombre' }
  end

end
