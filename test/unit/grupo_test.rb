# encoding: utf-8
require './test/test_helper'

class GrupoTest < ActiveSupport::TestCase

  test "debería negarse a guardarlo si los campos son nulos" do
    assert !Grupo.new.save, "permite guardar un grupo vacío"
  end

  test "debería negarse a guardar grupos duplicados" do
    assert create(:grupo).dup.invalid?, "permite guardar grupos duplicados"
  end

end
