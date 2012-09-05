# encoding: utf-8
require './test/test_helper'

class LimiteTest < ActiveSupport::TestCase

  setup do
    @limite = build_stubbed(:limite)
  end

  test "debería poder acceder a sus asociaciones" do
    assert @limite.respond_to? :tipo
    assert @limite.respond_to? :forma
    assert_nothing_raised do
      @limite.forma
      @limite.tipo
    end
    assert @limite.respond_to? :horizonte

    # Pruebo sus lookups
    assert TipoDeLimite.first.respond_to? :limites
    assert FormaDeLimite.first.respond_to? :limites
  end

end
