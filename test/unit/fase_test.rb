# -*- encoding : utf-8 -*-
require 'test_helper'

class FaseTest < ActiveSupport::TestCase

  test "debería negarse a guardarla si los campos son nulos" do
    assert !Fase.new.save, "permite guardar una fase vacía"
  end

  test "debería negarse a guardar fases duplicadas" do
    assert !Fase.new(fases(:uno).attributes).save, "permite guardar fases duplicadas"
  end

end
