# -*- encoding : utf-8 -*-
require 'test_helper'

class CalicataTest < ActiveSupport::TestCase

  fixtures :all

  setup do
    @atributos = {  :fecha => Date.today }
  end

  test "debería prohibir guardar calicatas sin fecha" do
    c = Calicata.new
    assert c.invalid?, "falta definir la fecha"
    assert !c.save, "no se puede guardar sin la fecha"
  end

  test "debería prohibir fechas del futuro" do
    c = Calicata.new :fecha => Date.today + 2
    assert c.invalid?, "la fecha es del futuro"
  end

  test "debería cargar el paisaje asociado" do
    @atributos[:paisaje_attributes] = { :simbolo => "Ps" }
    assert_difference 'Paisaje.count' do
      Calicata.create(@atributos)
    end
  end

  test "debería cargar y crear la serie asociada" do
    @atributos[:serie_attributes] = { :simbolo => 'As' }
    assert_difference 'Serie.count' do
      Calicata.create(@atributos)
    end
  end

  test "debería cargar y crear la capacidad asociada" do
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
