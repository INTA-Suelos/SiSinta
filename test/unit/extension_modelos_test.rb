# -*- encoding : utf-8 -*-
require 'test_helper'

class ExtensionModelosTest < ActiveSupport::TestCase

  fixtures :fases, :calicatas

  test "debería convertir el modelo a Array" do
    assert_instance_of Array, calicatas(:valida).como_arreglo, "no devuelve Array"
  end

  test "debería buscar y cargar las asociaciones" do
    assert_no_difference ('Fase.count') do
      Calicata.create fase_attributes: { nombre: fases(:uno).nombre }
    end
  end

  test "debería filtrar los atributos" do
    sin_atributo = Calicata.atributos_y_asociaciones excepto: :numero
    sin_asociacion = Calicata.atributos_y_asociaciones excepto: :ubicacion
    sin_ambos = Calicata.atributos_y_asociaciones excepto: [:numero, :ubicacion]

    assert_instance_of Array, sin_atributo, "no devuelve Array"
    assert_instance_of Array, sin_asociacion, "no devuelve Array"
    assert_instance_of Array, sin_ambos, "no devuelve Array"

    assert !sin_atributo.include?(:numero), "no filtra un atributo"
    assert !sin_asociacion.include?(:ubicacion), "no filtra una asociación"
    assert !(sin_ambos.include?(:numero) and sin_ambos.include?(:ubicacion)), "no filtra varias"
  end

end
