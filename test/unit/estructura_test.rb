# encoding: utf-8
require 'test_helper'

class EstructuraTest < ActiveSupport::TestCase

  fixtures :estructuras

  setup do
    @estructura = estructuras(:one)
  end

  test "debería poder acceder a sus asociaciones" do
    assert @estructura.respond_to? :tipo
    assert @estructura.respond_to? :clase
    assert @estructura.respond_to? :grado
    assert @estructura.respond_to? :horizonte

    # Pruebo sus lookups
    assert TipoDeEstructura.first.respond_to? :estructuras
    assert ClaseDeEstructura.first.respond_to? :estructuras
    assert GradoDeEstructura.first.respond_to? :estructuras
  end

end
