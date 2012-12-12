# encoding: utf-8
require './test/test_helper'

class PerfilTest < ActiveSupport::TestCase

  test "debería prohibir guardar perfiles sin fecha" do
    c = Perfil.new
    assert c.invalid?, "no se puede guardar sin la fecha"
  end

  test "debería prohibir fechas del futuro" do
    assert build_stubbed(:perfil_futuro).invalid?, "la fecha es del futuro"
  end

  test "debería cargar el paisaje asociado" do
    atributos = attributes_for(:perfil).merge(
      paisaje_attributes: { simbolo: "Ps" })
    assert_difference 'Paisaje.count' do
      c = Perfil.create(atributos)
      assert_empty c.errors.messages
      assert c.valid?, "No valida"
    end
  end

  test "debería cargar la ubicación asociada" do
    atributos = attributes_for(:perfil).merge(
      ubicacion_attributes: { descripcion: "Somewhere over the rainbow" } )
    assert_difference 'Ubicacion.count' do
      c = Perfil.create(atributos)
      assert_empty c.errors.messages
      assert c.valid?, "No valida"
    end
  end

end
