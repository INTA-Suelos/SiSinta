# encoding: utf-8
require './test/test_helper'

class PedregrosidadTest < ActiveSupport::TestCase

  test "carga la clase asociada" do
    atributos = { clase_id: ClaseDePedregosidad.last.id }

    assert_difference 'ClaseDePedregosidad.last.pedregosidades.count' do
      assert create(:pedregosidad).update_attributes(atributos)
    end
  end

  test "no carga pedregosidad sin perfil" do
    assert build_stubbed(:pedregosidad, :sin_perfil).invalid?, "Una pedregosidad sin perfil es válida"
  end

  test "accede a sus asociaciones" do
    pedregosidad = build_stubbed(:pedregosidad)
    assert pedregosidad.respond_to? :clase
    assert pedregosidad.respond_to? :subclase
    assert pedregosidad.respond_to? :perfil
    assert_nothing_raised do
      pedregosidad.clase
      pedregosidad.subclase
    end

    # Pruebo sus lookups
    assert ClaseDePedregosidad.first.respond_to? :pedregosidades
    assert SubclaseDePedregosidad.first.respond_to? :pedregosidades
  end

end
