# encoding: utf-8
require './test/test_helper'

class SerieTest < ActiveSupport::TestCase

  test "requiere el nombre" do
    assert build_stubbed(:serie_anonima).invalid?, "Valida sin nombre"
  end

  test "no permite nombres duplicados" do
    existente = create(:serie).nombre
    assert build_stubbed(:serie, nombre: existente).invalid?, "Permite nombres duplicados"
  end

  test "no permite símbolos duplicados" do
    existente = create(:serie).simbolo
    assert build_stubbed(:serie, simbolo: existente).invalid?, "Permite símbolos duplicados"
  end

  test "actualiza el contador de perfiles" do
    serie = create(:serie)
    assert_equal 0, serie.cantidad_de_perfiles, "No tiene valor omisión igual a 0"

    serie.perfiles.create attributes_for(:perfil).slice(:fecha)
    serie.reload
    assert_equal 1, serie.cantidad_de_perfiles, "No actualiza el contador"
  end

end
