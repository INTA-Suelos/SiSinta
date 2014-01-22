# encoding: utf-8
require './test/test_helper'

class PaisajeTest < ActiveSupport::TestCase

  test "no guarda sin perfil asociado" do
    assert Paisaje.new.invalid?, "permite guardar un paisaje sin perfil asociado"
  end

  test "guarda aunque sólo tiene perfil" do
    assert Paisaje.new(perfil: create(:perfil)).valid?, "se niega a guardar un paisaje en blanco"
  end

end
