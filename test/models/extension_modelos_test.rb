# encoding: utf-8
require './test/test_helper'

class ExtensionModelosTest < ActiveSupport::TestCase
  test "debería buscar y cargar las asociaciones" do
    existente = create(:fase).nombre
    assert_no_difference ('Fase.count') do
      Perfil.create fase_attributes: { nombre: existente }
    end
  end

  test "debería filtrar los atributos" do
    sin_atributo = Perfil.atributos_y_asociaciones excepto: :numero
    sin_asociacion = Perfil.atributos_y_asociaciones excepto: :ubicacion
    sin_ambos = Perfil.atributos_y_asociaciones excepto: [:numero, :ubicacion]

    assert_instance_of Array, sin_atributo, "no devuelve Array"
    assert_instance_of Array, sin_asociacion, "no devuelve Array"
    assert_instance_of Array, sin_ambos, "no devuelve Array"

    assert !sin_atributo.include?(:numero), "no filtra un atributo"
    assert !sin_asociacion.include?(:ubicacion), "no filtra una asociación"
    assert !(sin_ambos.include?(:numero) and sin_ambos.include?(:ubicacion)), "no filtra varias"
  end
end
