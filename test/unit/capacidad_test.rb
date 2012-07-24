# encoding: utf-8
require 'test_helper'

class CapacidadTest < ActiveSupport::TestCase

  fixtures :capacidades

  setup do
    @capacidad = capacidades(:poca)
  end

  test "debería cargar la clase asociada" do
    @atributos = { clase_id: ClaseDeCapacidad.first.id }
    assert_difference 'ClaseDeCapacidad.first.capacidades.count' do
      @capacidad.update_attributes(@atributos)
      assert @capacidad.valid?
    end
  end

  test "debería guardar la relación con la/s subclase/s" do
    @atributos = { subclase_ids: [ SubclaseDeCapacidad.first.id ] }
    @capacidad.update_attributes(@atributos)
    assert @capacidad.valid?
    assert @capacidad.subclase_ids.include?(SubclaseDeCapacidad.first.id), 'no agrega una subclase (1)'
    assert @capacidad.subclases.include?(SubclaseDeCapacidad.first), 'no agrega una subclase'

    @atributos = { subclase_ids: [  SubclaseDeCapacidad.first.id,
                                    SubclaseDeCapacidad.last.id   ] }

    @capacidad.update_attributes(@atributos)
    assert @capacidad.valid?
    assert @capacidad.subclase_ids.include?(SubclaseDeCapacidad.first.id), 'no agrega varias subclases'
    assert @capacidad.subclases.include?(SubclaseDeCapacidad.first), 'no agrega varias subclases'
    assert @capacidad.subclase_ids.include?(SubclaseDeCapacidad.last.id), 'no agrega varias subclases'
    assert @capacidad.subclases.include?(SubclaseDeCapacidad.last), 'no agrega varias subclases'
  end

  test "debería negarse a cargar capacidad sin calicata" do
    @atributos = { clase_id: ClaseDeCapacidad.first.id }
    assert Capacidad.new(@atributos).invalid?, "una capacidad sin calicata es válida"
  end

  test "debería poder acceder a sus asociaciones" do
    assert @capacidad.respond_to? :clase
    assert @capacidad.respond_to? :subclases
    assert @capacidad.respond_to? :calicata

    # Pruebo sus lookups
    assert ClaseDeCapacidad.first.respond_to? :capacidades
    assert SubclaseDeCapacidad.first.respond_to? :capacidades
  end

end
