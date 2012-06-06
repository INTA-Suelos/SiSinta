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
    @u.x = 50
    @u.y = 50
    srid = @u.coordenadas.srid
    assert 4326 == srid, "#{srid} es un SRID incorrecto"
  end

  test "punto, x e y manejan coordenadas correctamente" do
    u = Ubicacion.new x: 22.1, y: 33.2
    assert_equal "22.1 33.2", u.punto
    assert 22.1 == u.x
    assert 33.2 == u.y
  end

  test "aproxima las coordenadas según mosaico-recorrido-aerofoto" do
    flunk "no implementado todavía"
    #u = Ubicacion.new mosaico: '3760-2-2'
    #assert_equal '-60,708333333 -36,083333333', u.aproximar
  end

  test "debería soportar proj4" do
    assert RGeo::CoordSys::Proj4::supported?
  end

end
