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

end
