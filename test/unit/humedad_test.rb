# encoding: utf-8
require 'test_helper'

class HumedadTest < ActiveSupport::TestCase

  fixtures :humedades

  setup do
    @humedad = humedades(:uno)
  end

  test "debería cargar la clase asociada" do
    @atributos = { clase_id: ClaseDeHumedad.last.id }
    assert_difference 'ClaseDeHumedad.last.humedades.count' do
      @humedad.update_attributes(@atributos)
      assert @humedad.valid?
    end
  end

  test "debería negarse a cargar humedad sin calicata" do
    @atributos = { clase_id: ClaseDeHumedad.first.id }
    assert Humedad.new(@atributos).invalid?, "una humedad sin calicata es válida"
  end

  test "debería poder acceder a sus asociaciones" do
    assert @humedad.respond_to? :clase
    assert @humedad.respond_to? :subclase
    assert @humedad.respond_to? :calicata
    assert_nothing_raised do
      @humedad.clase
      @humedad.subclase
    end

    # Pruebo sus lookups
    assert ClaseDeHumedad.first.respond_to? :humedades
    assert SubclaseDeHumedad.first.respond_to? :humedades
  end

end
