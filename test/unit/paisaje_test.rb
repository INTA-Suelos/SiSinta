# -*- encoding : utf-8 -*-
require 'test_helper'

class PaisajeTest < ActiveSupport::TestCase

  fixtures :calicatas

  test "debería negarse a guardarla si los campos son nulos" do
    assert !Paisaje.new.save, "permite guardar un paisaje vacío"
  end

  test "debería negarse a guardar un paisaje sin datos" do
    flunk
  end

end
