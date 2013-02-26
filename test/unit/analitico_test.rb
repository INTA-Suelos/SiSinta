# encoding: utf-8
require './test/test_helper'

class AnalisisTest < ActiveSupport::TestCase

  setup do
    @analisis = build_stubbed(:analisis)
  end

  test 'devuelve materia_organica_cn si no es null' do
    @analisis.materia_organica_cn = 4
    @analisis.materia_organica_n = 1.1
    @analisis.materia_organica_c = 1.1
    assert_equal 4, @analisis.materia_organica_cn
  end

  test 'devuelve la relación entre las materias orgánicas o cero' do
    assert_equal nil, @analisis.materia_organica_cn
    @analisis.materia_organica_c = 4
    assert_equal nil, @analisis.materia_organica_cn
    @analisis.materia_organica_c = nil
    @analisis.materia_organica_n = 2
    assert_equal nil, @analisis.materia_organica_cn
    @analisis.materia_organica_c = 4
    assert_equal 2, @analisis.materia_organica_cn
  end

  test 'permite asignación masiva de ciertos atributos' do
    assert Analisis.create(attributes_for(:analisis))
  end

end
