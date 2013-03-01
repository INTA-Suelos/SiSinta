# encoding: utf-8
require './test/test_helper'

class AnaliticoTest < ActiveSupport::TestCase

  setup do
    @analitico = build_stubbed(:analitico)
  end

  test 'devuelve materia_organica_cn si no es null' do
    @analitico.materia_organica_cn = 4
    @analitico.materia_organica_n = 1.1
    @analitico.materia_organica_c = 1.1
    assert_equal 4, @analitico.materia_organica_cn
  end

  test 'devuelve la relación entre las materias orgánicas o cero' do
    assert_equal nil, @analitico.materia_organica_cn
    @analitico.materia_organica_c = 4
    assert_equal nil, @analitico.materia_organica_cn
    @analitico.materia_organica_c = nil
    @analitico.materia_organica_n = 2
    assert_equal nil, @analitico.materia_organica_cn
    @analitico.materia_organica_c = 4
    assert_equal 2, @analitico.materia_organica_cn
  end

  test 'permite asignación masiva de ciertos atributos' do
    assert Analitico.create(attributes_for(:analitico))
  end

  test 'usa precisión 00.00 en ciertos atributos' do
    a = build(:analitico, horizonte: build(:horizonte),
      humedad: 99.99,
      arcilla: 0.01,
      materia_organica_c: 0.02,
      materia_organica_n: 0.03,
      limo_2_20: 0.04,
      limo_2_50: 0.05,
      arena_muy_fina: 0.06,
      arena_fina: 0.07,
      arena_media: 0.08,
      arena_gruesa: 0.09,
      arena_muy_gruesa: 0.10,
      ca_co3: 0.11,
      agua_15_atm: 0.12,
      agua_util: 0.13,
      saturacion_t: 0.14,
      saturacion_s_h: 0.15,
      agua_3_atm: 0.16 )
      
    assert a.valid?
    a.save
    a.reload
    assert_equal 99.99, a.humedad.to_f  # TODO por qué no lo convierte?
    assert_equal 0.01, a.arcilla
    assert_equal 0.02, a.materia_organica_c
    assert_equal 0.03, a.materia_organica_n
    assert_equal 0.04, a.limo_2_20
    assert_equal 0.05, a.limo_2_50
    assert_equal 0.06, a.arena_muy_fina
    assert_equal 0.07, a.arena_fina.to_f  # TODO por qué no lo convierte?
    assert_equal 0.08, a.arena_media
    assert_equal 0.09, a.arena_gruesa
    assert_equal 0.10, a.arena_muy_gruesa
    assert_equal 0.11, a.ca_co3
    assert_equal 0.12, a.agua_15_atm
    assert_equal 0.13, a.agua_util
    assert_equal 0.14, a.saturacion_t
    assert_equal 0.15, a.saturacion_s_h
    assert_equal 0.16, a.agua_3_atm
  end
end
