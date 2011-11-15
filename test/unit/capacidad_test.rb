# -*- encoding : utf-8 -*-
require 'test_helper'

class CapacidadTest < ActiveSupport::TestCase

  setup do
    @atributos = {}
  end

  test "debería cargar la clase asociada" do
    assert_nothing_raised do
      @atributos[:capacidad_clase_id] = CapacidadClase.first.id
      assert_difference 'CapacidadClase.first.reload.capacidades.count' do
        Capacidad.create(@atributos)
      end
    end
  end

  test "debería cargar guardar la relación con la subclase" do
    assert_nothing_raised do
      @atributos[:subclase_ids] = [ CapacidadSubclase.first.id ]
      assert_difference 'CapacidadSubclase.first.capacidades.count' do
        Capacidad.create(@atributos)
      end
    end
  end

end
