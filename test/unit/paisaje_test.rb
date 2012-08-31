# encoding: utf-8
require './test/test_helper'

class PaisajeTest < ActiveSupport::TestCase

  fixtures :calicatas

  test "debería negarse a guardarla sin calicata asociada" do
    assert Paisaje.new.invalid?, "permite guardar un paisaje sin calicata asociada"
  end

  test "debería permitir guardar un paisaje que sólo tiene calicata" do
    assert Paisaje.new(:calicata => calicatas(:uno)).valid?, "se niega a guardar un paisaje en blanco"
  end

end
