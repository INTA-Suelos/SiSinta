# -*- encoding : utf-8 -*-
require 'test_helper'

class PaisajeTest < ActiveSupport::TestCase

  fixtures :calicatas

  test "debería negarse a guardarla sin calicata asociada" do
    assert !Paisaje.new.save, "permite guardar un paisaje sin calicata asociada"
  end

  test "debería negarse a guardar un paisaje con datos vacíos" do
    assert !Paisaje.new(:calicata => calicatas(:uno)).save, "permite guardar un paisaje sin datos"
  end

end
