# encoding: utf-8
require './test/test_helper'

class ProyectoTest < ActiveSupport::TestCase

  test "no debe permitir nombres duplicados" do
    existente = create(:proyecto).nombre
    assert build_stubbed(:proyecto, nombre: existente).invalid?,
      "Está permitiendo nombres duplicados"
  end

  test "no debe permitir nombres en blanco" do
    assert build_stubbed(:proyecto, nombre: '').invalid?,
      "Está permitiendo nombres en blanco"
  end

end
