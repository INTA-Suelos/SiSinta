# encoding: utf-8
require './test/test_helper'

class CapacidadTest < ActiveSupport::TestCase

  test "carga la clase asociada" do
    atributos = { clase_id: ClaseDeCapacidad.first.id }

    assert_difference 'ClaseDeCapacidad.first.capacidades.count' do
      assert create(:capacidad).update_attributes(atributos)
    end
  end

  test "guarda la relación con una subclase" do
    capacidad = create(:capacidad, subclase_ids: [ SubclaseDeCapacidad.first.id ])

    assert capacidad.valid?
    assert capacidad.subclase_ids.include?(SubclaseDeCapacidad.first.id), 'no agrega una subclase (1)'
    assert capacidad.subclases.include?(SubclaseDeCapacidad.first), 'no agrega una subclase'
  end

  test "guarda la relación con varias subclases" do
    atributos = { subclase_ids: [ SubclaseDeCapacidad.first.id,
                                  SubclaseDeCapacidad.last.id   ] }
    capacidad = create(:capacidad, atributos)

    assert capacidad.valid?
    assert capacidad.subclase_ids.include?(SubclaseDeCapacidad.first.id), 'no agrega varias subclases'
    assert capacidad.subclases.include?(SubclaseDeCapacidad.first), 'no agrega varias subclases'
    assert capacidad.subclase_ids.include?(SubclaseDeCapacidad.last.id), 'no agrega varias subclases'
    assert capacidad.subclases.include?(SubclaseDeCapacidad.last), 'no agrega varias subclases'
  end

  test "no carga capacidad sin perfil" do
    assert build_stubbed(:capacidad, :sin_perfil).invalid?, "una capacidad sin perfil es válida"
  end

  test "puede acceder a sus asociaciones" do
    capacidad = build_stubbed(:capacidad)
    assert capacidad.respond_to? :clase
    assert capacidad.respond_to? :subclases
    assert capacidad.respond_to? :perfil
    assert_nothing_raised do
      capacidad.clase
      capacidad.subclases
    end

    # Pruebo sus lookups
    assert ClaseDeCapacidad.first.respond_to? :capacidades
    assert SubclaseDeCapacidad.first.respond_to? :capacidades
  end

  test "ignora elementos vacíos" do
    capacidad = build_stubbed(:capacidad)
    capacidad.subclase_ids = [1, '', nil, 2]
    assert_equal [1, 2], capacidad.subclase_ids
  end

  test "ignora ids inexistentes" do
    capacidad = build_stubbed(:capacidad)
    capacidad.subclase_ids = [1, '2', (SubclaseDeCapacidad.count + 1)]
    assert_equal [1, 2], capacidad.subclase_ids
  end
end
