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

  test "debería cargar y crear la serie asociada" do
    assert_nothing_raised do
      @atributos[:serie_attributes] = { :simbolo => 'As' }
      assert_difference 'Serie.count' do
        Calicata.create(@atributos)
      end
    end
  end

  test "debería cargar y crear la capacidad asociada" do
    assert_nothing_raised do
      @atributos[:capacidad_attributes] =
        { :subclases_attributes => [ { :codigo => 's' } ],
          :clase_attributes => { :codigo => 'clase' } }
      assert_difference 'Capacidad.count' do
        assert_difference 'CapacidadClase.count' do
          assert_difference 'CapacidadSubclase.count' do
            assert Calicata.create(@atributos)
          end
        end
      end
    end
  end

  test "debería cargar el drenaje de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:drenaje_attributes] = { :valor => 'drenaje' }
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el posicion de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:posicion_attributes] = { :valor => 'posicion' }
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el anegamiento de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:anegamiento_attributes] = { :valor => 'anegamiento' }
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el relieve de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:relieve_attributes] = { :valor => 'relieve' }
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el permeabilidad de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:permeabilidad_attributes] = { :valor => 'permeabilidad' }
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el pendiente de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:pendiente_attributes] = { :valor => 'pendiente' }
      Calicata.create(@atributos)
    end
  end

  test "debería cargar el escurrimiento de la tabla de lookup" do
    assert_nothing_raised do
      @atributos[:escurrimiento_attributes] = { :valor => 'escurrimiento' }
      Calicata.create(@atributos)
    end
  end

end
