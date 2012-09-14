# encoding: utf-8
require './test/test_helper'

class PerfilTest < ActiveSupport::TestCase

  setup do
    @atributos = { fecha: Date.today, nombre: 'alguno' }
  end

  test "debería prohibir guardar perfiles sin fecha" do
    c = Perfil.new
    assert c.invalid?, "no se puede guardar sin la fecha"
  end

  test "debería prohibir fechas del futuro" do
    assert build_stubbed(:perfil_futuro).invalid?, "la fecha es del futuro"
  end

  # TODO factorygirlizar
  test "debería cargar el paisaje asociado" do
    @atributos[:paisaje_attributes] = { simbolo: "Ps" }
    assert_difference 'Paisaje.count' do
      c = Perfil.create(@atributos)
      assert_empty c.errors.messages
      assert c.valid?, "No valida"
    end
  end

  # TODO factorygirlizar
  test "debería cargar la ubicación asociada" do
    @atributos[:ubicacion_attributes] = {
      descripcion: "Somewhere over the rainbow"}
    assert_difference 'Ubicacion.count' do
      c = Perfil.create(@atributos)
      assert_empty c.errors.messages
      assert c.valid?, "No valida"
    end
  end

  test "debería requerir el nombre" do
    assert build_stubbed(:perfil_anonimo).invalid?, "Valida sin nombre"
  end

  test "no debería permitir nombres duplicados" do
    existente = create(:perfil).nombre
    assert build_stubbed(:perfil, nombre: existente).invalid?, "Permite nombres duplicados"
  end

end
