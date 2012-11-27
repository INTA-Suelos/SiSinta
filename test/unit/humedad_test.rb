# encoding: utf-8
require './test/test_helper'

class HumedadTest < ActiveSupport::TestCase

  test "debería cargar la clase asociada" do
    atributos = { clase_id: ClaseDeHumedad.last.id }

    assert_difference 'ClaseDeHumedad.last.humedades.count' do
      assert create(:humedad).update_attributes(atributos)
    end
  end

  test "debería negarse a cargar humedad sin perfil" do
    assert build_stubbed(:humedad, :sin_perfil).invalid?, "Una humedad sin perfil es válida"
  end

  test "debería poder acceder a sus asociaciones" do
    humedad = build_stubbed(:humedad)
    assert humedad.respond_to? :clase
    assert humedad.respond_to? :subclase
    assert humedad.respond_to? :perfil
    assert_nothing_raised do
      humedad.clase
      humedad.subclase
    end

    # Pruebo sus lookups
    assert ClaseDeHumedad.first.respond_to? :humedades
    assert SubclaseDeHumedad.first.respond_to? :humedades
  end

end
