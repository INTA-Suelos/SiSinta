# -*- encoding : utf-8 -*-
require 'test_helper'

class UbicacionTest < ActiveSupport::TestCase

  setup do
    @atributos = {}
    @u = Ubicacion.new(:calicata => calicatas(:uno))
  end

  test "debería negarse a cargar la ubicación sin calicata" do
    assert Ubicacion.new(@atributos).invalid?, "una ubicación sin calicata es válida"
    assert @u.valid?, "una ubicación sólo con calicata es válida"
  end

  test "debería negarse a guardar un punto mal formado" do
    assert Ubicacion.new(:coordenadas => 'rms').invalid?, "permite guardar 'rms' como latitud/longitud"
  end

  test "debería validar latitud;longitud sólo entre -90/90 y -180/180" do
    regex = Ubicacion::EPSG_4326
    assert_match regex, '90;180', "no permite 90;180"
    assert_match regex, '89.000000;120.000000', "no permite 89.000000;120.000000"
    assert_match regex, '181.00;120.00', "permite 181.00;120.00"
    assert_match regex, '-90.00001;-180.0000', "permite -90.00001;-180.0000"
  end

  test "las coordenadas deberían estar en SRID 4326" do
    @u.lat_lon= "50 50"
    srid = @u.coordenadas.srid
    assert 4326 == srid, "#{srid} es un SRID incorrecto"
  end

  test "lat_lon maneja coordenadas correctamente" do
    u = Ubicacion.new :lat_lon => "22.1 33.2"
    assert_equal "22.1 33.2", u.lat_lon
    assert 22.1 == u.latitud
    assert 33.2 == u.longitud
  end

  test "aproxima las coordenadas según mosaico-recorrido-aerofoto" do
    u = Ubicacion.new mosaico: '3760-2-2'
    assert_equal '-60,708333333 -36,083333333', u.aproximar
  end

end
