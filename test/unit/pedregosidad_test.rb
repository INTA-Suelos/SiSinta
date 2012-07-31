# encoding: utf-8
require 'test_helper'

class PedregrosidadTest < ActiveSupport::TestCase

  fixtures :pedregosidades

  setup do
    @pedregosidad = pedregosidades(:uno)
  end

  test "debería cargar la clase asociada" do
    @atributos = { clase_id: ClaseDePedregosidad.last.id }
    assert_difference 'ClaseDePedregosidad.last.pedregosidades.count' do
      @pedregosidad.update_attributes(@atributos)
      assert @pedregosidad.valid?
    end
  end

  test "debería negarse a cargar pedregosidad sin calicata" do
    @atributos = { clase_id: ClaseDePedregosidad.first.id }
    assert Pedregosidad.new(@atributos).invalid?, "una pedregosidad sin calicata es válida"
  end

  test "debería poder acceder a sus asociaciones" do
    assert @pedregosidad.respond_to? :clase
    assert @pedregosidad.respond_to? :subclase
    assert @pedregosidad.respond_to? :calicata
    assert_nothing_raised do
      @pedregosidad.clase
      @pedregosidad.subclase
    end

    # Pruebo sus lookups
    assert ClaseDePedregosidad.first.respond_to? :pedregosidades
    assert SubclaseDePedregosidad.first.respond_to? :pedregosidades
  end

end
