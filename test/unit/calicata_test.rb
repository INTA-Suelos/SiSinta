# -*- encoding : utf-8 -*-
require 'test_helper'

class CalicataTest < ActiveSupport::TestCase

  fixtures :all

  setup do
    @atributos = {  :fecha => Date.today }
  end

  test "debería prohibir guardar calicatas sin fecha" do
    c = Calicata.new
    assert c.invalid?, "no se puede guardar sin la fecha"
  end

  test "debería prohibir fechas del futuro" do
    c = Calicata.new :fecha => Date.today + 2
    assert c.invalid?, "la fecha es del futuro"
  end

  test "debería cargar el paisaje asociado" do
    assert_nothing_raised do
      @atributos[:paisaje_attributes] = { :simbolo => "Ps" }
      assert_difference 'Paisaje.count' do
        Calicata.create(@atributos)
      end
    end
  end

  test "debería cargar la ubicación asociada" do
    assert_nothing_raised do
      @atributos[:ubicacion_attributes] = { :descripcion => "Somewhere over the rainbow" }
      assert_difference 'Ubicacion.count' do
        Calicata.create(@atributos)
      end
    end
  end

  test "debería cargar y crear la serie asociada" do
    assert_nothing_raised do
      @atributos[:serie_attributes] = { :simbolo => 'As' }
      assert_difference 'Serie.count' do
        Calicata.create(@atributos)
      end
    end
  end

  test "debería cargar la capacidad asociada" do
    assert_nothing_raised do
      @c = Calicata.create(@atributos)
      assert_difference 'CapacidadClase.first.calicatas.count' do
        assert_difference 'CapacidadSubclase.first.calicatas.count' do
          @c.capacidad = Capacidad.new(:capacidad_clase_id => CapacidadClase.first.id,
                                       :calicata_id => @c.id)
          assert @c.save
          @c.capacidad.subclases << CapacidadSubclase.first
        end
      end
    end
  end

  test "debería cargar el drenaje de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:drenaje_id] = Drenaje.first.id
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el posicion de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:posicion_id] = Posicion.first.id
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el anegamiento de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:anegamiento_id] = Anegamiento.first.id
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el relieve de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:relieve_id] = Relieve.first.id
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el permeabilidad de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:permeabilidad_id] = Permeabilidad.first.id
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el pendiente de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:pendiente_id] = Pendiente.first.id
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el escurrimiento de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:escurrimiento_id] = Escurrimiento.first.id
      Calicata.create(@atributos)
    end
  end

end
