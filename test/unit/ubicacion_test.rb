# -*- encoding : utf-8 -*-
require 'test_helper'

class UbicacionTest < ActiveSupport::TestCase

  setup do
    @atributos = {}
    @u = ubicaciones(:one)
  end

  test "debería negarse a cargar la ubicación sin calicata" do
    assert Ubicacion.new(@atributos).invalid?, "una ubicación sin calicata es válida"
  end

  test "debería negarse a guardar un punto mal formado" do
    assert Ubicacion.new(:coordenadas => "sarasa").invalid?, "permite guardar 'sarasa' como latitud/longitud"
  end

  test "debería validar latitud;longitud sólo entre -90/90 y -180/180" do
    regex = Ubicacion::EPSG_4326
    assert_match regex, '90;180', "no permite 90;180"
    assert_match regex, '89.000000;120.000000', "no permite 89.000000;120.000000"
    assert_match regex, '181.00;120.00', "permite 181.00;120.00"
    assert_match regex, '-90.00001;-180.0000', "permite -90.00001;-180.0000"
  end

  test "las coordenadas deberían estar en SRID 4326" do
    assert_match /4326/, @u.coordenadas.srid
  end

end
