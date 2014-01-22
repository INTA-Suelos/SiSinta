# encoding: utf-8
require './test/test_helper'

class FaseTest < ActiveSupport::TestCase

  test "no guarda si los campos son nulos" do
    assert !Fase.new.save, "permite guardar una fase vacía"
  end

  test "no guarda duplicadas" do
    assert create(:fase).dup.invalid?, "permite guardar fases duplicados"
  end

end
