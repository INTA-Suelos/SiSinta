# encoding: utf-8
require './test/test_helper'

class CalicataTest < ActiveSupport::TestCase

  fixtures :all

  setup do
    @atributos = { fecha: Date.today, nombre: 'alguno' }
  end

  test "debería prohibir guardar calicatas sin fecha" do
    c = Calicata.new
    assert c.invalid?, "no se puede guardar sin la fecha"
  end

  test "debería prohibir fechas del futuro" do
    c = Calicata.new fecha: Date.today + 2
    assert c.invalid?, "la fecha es del futuro"
  end

  test "debería cargar el paisaje asociado" do
    @atributos[:paisaje_attributes] = { simbolo: "Ps" }
    assert_difference 'Paisaje.count' do
      c = Calicata.create(@atributos)
      assert_empty c.errors.messages
      assert c.valid?, "No valida"
    end
  end

  test "debería cargar la ubicación asociada" do
    @atributos[:ubicacion_attributes] = {
      descripcion: "Somewhere over the rainbow"}
    assert_difference 'Ubicacion.count' do
      c = Calicata.create(@atributos)
      assert_empty c.errors.messages
      assert c.valid?, "No valida"
    end
  end

  test "debería cargar el drenaje de la tabla de lookup" do
    @atributos[:drenaje_id] = Drenaje.first.id
    c = Calicata.create(@atributos)
    assert_instance_of Drenaje, c.drenaje
  end

  test "debería cargar la posicion de la tabla de lookup" do
    @atributos[:posicion_id] = Posicion.first.id
    c = Calicata.create(@atributos)
    assert_instance_of Posicion, c.posicion
  end

  test "debería cargar el anegamiento de la tabla de lookup" do
    @atributos[:anegamiento_id] = Anegamiento.first.id
    c = Calicata.create(@atributos)
    assert_instance_of Anegamiento, c.anegamiento
  end

  test "debería cargar el relieve de la tabla de lookup" do
    @atributos[:relieve_id] = Relieve.first.id
    c = Calicata.create(@atributos)
    assert_instance_of Relieve, c.relieve
  end

  test "debería cargar la permeabilidad de la tabla de lookup" do
    @atributos[:permeabilidad_id] = Permeabilidad.first.id
    c = Calicata.create(@atributos)
    assert_instance_of Permeabilidad, c.permeabilidad
  end

  test "debería cargar la pendiente de la tabla de lookup" do
    @atributos[:pendiente_id] = Pendiente.first.id
    c = Calicata.create(@atributos)
    assert_instance_of Pendiente, c.pendiente
  end

  test "debería cargar el escurrimiento de la tabla de lookup" do
    @atributos[:escurrimiento_id] = Escurrimiento.first.id
    c = Calicata.create(@atributos)
    assert_instance_of Escurrimiento, c.escurrimiento
  end

  test "debería requerir el nombre" do
    assert Calicata.new(calicatas(:anonima).attributes).invalid?, "Valida sin nombre"
  end

  test "no debería permitir nombres duplicados" do
    c = Calicata.new(modal: true, nombre: calicatas(:carabela).nombre, fecha: Date.today)
    assert c.invalid?, "Permite nombres duplicados"
  end

end
