# -*- encoding : utf-8 -*-
require 'test_helper'

class GrupoTest < ActiveSupport::TestCase

  test "debería negarse a guardarlo si los campos son nulos" do
    assert !Grupo.new.save, "permite guardar un grupo vacío"
  end

  test "debería negarse a guardar grupos duplicados" do
    assert !Grupo.new(grupos(:uno).attributes).save, "permite guardar grupos duplicados"
  end

end
