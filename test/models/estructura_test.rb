# encoding: utf-8
require './test/test_helper'

class EstructuraTest < ActiveSupport::TestCase

  setup do
    @estructura = build_stubbed(:estructura)
  end

  test "accede a sus asociaciones" do
    assert @estructura.respond_to? :tipo
    assert @estructura.respond_to? :clase
    assert @estructura.respond_to? :grado
    assert_nothing_raised do
      @estructura.tipo
      @estructura.clase
      @estructura.grado
    end
    assert @estructura.respond_to? :horizonte

    # Pruebo sus lookups
    assert TipoDeEstructura.first.respond_to? :estructuras
    assert ClaseDeEstructura.first.respond_to? :estructuras
    assert GradoDeEstructura.first.respond_to? :estructuras
  end

end
