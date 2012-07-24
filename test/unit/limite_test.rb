# encoding: utf-8
require 'test_helper'

class LimiteTest < ActiveSupport::TestCase

  fixtures :limites

  setup do
    @limite = limites(:one)
  end

  test "debería poder acceder a sus asociaciones" do
    assert @limite.respond_to? :tipo
    assert @limite.respond_to? :forma
    assert @limite.respond_to? :horizonte

    # Pruebo sus lookups
    assert TipoDeLimite.first.respond_to? :limites
    assert FormaDeLimite.first.respond_to? :limites
  end

end
