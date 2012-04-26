# -*- encoding : utf-8 -*-
require 'test_helper'

class AnalisisTest < ActiveSupport::TestCase

  fixtures :analisis

  setup do
    @analisis = analisis(:uno)
  end

  test "debería devolver la relación entre las materias orgánicas o cero" do
    assert_equal 0, @analisis.materia_organica_cn
    @analisis.materia_organica_c = 4
    assert_equal 0, @analisis.materia_organica_cn
    @analisis.materia_organica_c = nil
    @analisis.materia_organica_n = 2
    assert_equal 0, @analisis.materia_organica_cn
    @analisis.materia_organica_c = 4
    assert_equal 2, @analisis.materia_organica_cn
  end

  # test "the truth" do
  #   assert true
  # end
end
