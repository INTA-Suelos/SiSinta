# encoding: utf-8
require './test/test_helper'

class PaisajeTest < ActiveSupport::TestCase

  test "debería negarse a guardarla sin perfil asociado" do
    assert Paisaje.new.invalid?, "permite guardar un paisaje sin perfil asociado"
  end

  test "debería permitir guardar un paisaje que sólo tiene perfil" do
    assert Paisaje.new(perfil: create(:perfil)).valid?, "se niega a guardar un paisaje en blanco"
  end

end
