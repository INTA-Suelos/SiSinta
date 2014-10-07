# encoding: utf-8
require './test/test_helper'

class SerieTest < ActiveSupport::TestCase
  test 'requiere el nombre' do
    assert build_stubbed(:serie_anonima).invalid?, 'Valida sin nombre'
  end

  test 'no permite nombres duplicados dentro de la misma provincia' do
    existente = create(:serie, provincia_id: 1).nombre

    assert build_stubbed(:serie, provincia_id: 1, nombre: existente).invalid?, 'Permite nombres duplicados'
  end

  test 'no permite símbolos duplicados dentro de la misma provincia' do
    existente = create(:serie, provincia_id: 1).simbolo

    assert build_stubbed(:serie, provincia_id: 1, simbolo: existente).invalid?, 'Permite símbolos duplicados'
  end

  test 'permite nombres duplicados en diferentes provincias' do
    existente = create(:serie, provincia_id: 1).nombre

    assert build_stubbed(:serie, provincia_id: 2, nombre: existente).valid?
  end

  test 'permite símbolos duplicados en diferentes provincias' do
    existente = create(:serie, provincia_id: 1).simbolo

    assert build_stubbed(:serie, provincia_id: 2, simbolo: existente).valid?
  end

  test 'el contador de perfiles inicia en 0' do
    serie = create(:serie)
    assert_equal 0, serie.cantidad_de_perfiles, 'No tiene valor omisión igual a 0'
  end

  test 'actualiza el contador de perfiles' do
    serie = create(:serie)
    serie.perfiles.create attributes_for(:perfil).slice(:fecha)

    assert_equal 1, serie.reload.cantidad_de_perfiles, 'No actualiza el contador'
  end
end
