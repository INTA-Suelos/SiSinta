# encoding: utf-8
require './test/test_helper'

class HumedadTest < ActiveSupport::TestCase

  test "carga la clase asociada" do
    atributos = { clase_id: ClaseDeHumedad.last.id }

    assert_difference 'ClaseDeHumedad.last.humedades.count' do
      assert create(:humedad).update_attributes(atributos)
    end
  end

  test "no carga humedad sin perfil" do
    assert build_stubbed(:humedad, :sin_perfil).invalid?, "Una humedad sin perfil es válida"
  end

  test "guarda la relación con una subclase" do
    humedad = create(:humedad, subclase_ids: [ SubclaseDeHumedad.first.id ])

    assert humedad.valid?
    assert humedad.subclase_ids.include?(SubclaseDeHumedad.first.id),
      'no agrega una subclase mediante el id'
    assert humedad.subclases.include?(SubclaseDeHumedad.first),
      'no agrega una subclase mediante el modelo'
  end

  test "guarda la relación con varias subclases" do
    atributos = { subclase_ids: [ SubclaseDeHumedad.first.id,
                                  SubclaseDeHumedad.last.id   ] }
    humedad = create(:humedad, atributos)

    assert humedad.valid?
    assert humedad.subclase_ids.include?(SubclaseDeHumedad.first.id), 'no agrega varias subclases'
    assert humedad.subclases.include?(SubclaseDeHumedad.first), 'no agrega varias subclases'
    assert humedad.subclase_ids.include?(SubclaseDeHumedad.last.id), 'no agrega varias subclases'
    assert humedad.subclases.include?(SubclaseDeHumedad.last), 'no agrega varias subclases'
  end

  test "puede acceder a sus asociaciones" do
    humedad = build_stubbed(:humedad)
    assert humedad.respond_to? :clase
    assert humedad.respond_to? :subclases
    assert humedad.respond_to? :perfil
    assert_nothing_raised do
      humedad.clase
      humedad.subclases
    end

    # Pruebo sus lookups
    assert ClaseDeHumedad.first.respond_to? :humedades
    assert SubclaseDeHumedad.first.respond_to? :humedades
  end

  test "ignora elementos vacíos" do
    humedad = build_stubbed(:humedad)
    humedad.subclase_ids = [1, '', nil, 2]
    assert_equal [1, 2], humedad.subclase_ids
  end

  test "ignora ids inexistentes" do
    humedad = build_stubbed(:humedad)
    humedad.subclase_ids = [1, '2', (SubclaseDeHumedad.count + 1)]
    assert_equal [1, 2], humedad.subclase_ids
  end
end
