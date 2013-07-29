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

  test 'permite asignación masiva de ciertos atributos' do
    assert Analitico.create(attributes_for(:analitico))
  end

  test 'usa precisión 000.00 en los porcentajes' do
    a = build(:analitico, horizonte: build(:horizonte),
      humedad: 99.99,
      arcilla: 0.01,
      materia_organica_c: 100,
      limo_2_20: 0.04,
      limo_2_50: '100',
      arena_muy_fina: 0.06,
      arena_fina: 100.000,
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
    assert_equal 100, a.materia_organica_c
    assert_equal 0.04, a.limo_2_20
    assert_equal 100, a.limo_2_50
    assert_equal 0.06, a.arena_muy_fina
    assert_equal 100, a.arena_fina.to_f  # TODO por qué no lo convierte?
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

  test 'usa precisión 000.000 para materia_organica_n' do
    a = build(:analitico, horizonte: build(:horizonte),
      materia_organica_n: 0.004 )

    assert a.valid?
    a.save
    a.reload
    assert_equal 0.004, a.materia_organica_n.to_f

    a.update_attribute('materia_organica_n', 100)
    a.reload
    assert_equal 100, a.materia_organica_n
  end

  test 'usa precisión 000000000000000000.0 en materia_organica_cn' do
    a = build(:analitico, horizonte: build(:horizonte),
      materia_organica_cn: 0.3 )

    assert a.valid?
    a.save
    a.reload
    assert_equal 0.3, a.materia_organica_cn

    a.update_attribute('materia_organica_cn', 999999999999999999.9)
    a.reload
    assert_equal 999999999999999999.9, a.materia_organica_cn.to_f
  end
end
