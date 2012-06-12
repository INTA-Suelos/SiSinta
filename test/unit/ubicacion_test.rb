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

  test "debería validar la latitud (x) sólo entre -90 y 90" do
    validos =   [-90, -90.0000, "24° 70'", 0, -89.99999999, 90, "89° 59' 59\"" ]
    invalidos = [90.000001, -250, "89° 60' 30\""]

    @u.y = 0

    validos.each do |v|
      @u.x = v
      assert @u.valid?, "#{v} no pasa la validación por #{@u.errors.messages}"
    end

    invalidos.each do |v|
      @u.x = v
      assert @u.invalid?, "#{v} pasa la validación por #{@u.errors.messages}"
    end
  end

  test "debería validar la longitud (y) sólo entre -180 y 180" do
    validos =   [-180, -180.0000, "-179° 60' 0\"", 0, "180°", -179.99999999, 180]
    invalidos = [-181, 180.000001, "-179° 60' 1\"", "180° 1'", -250]

    @u.x = 0

    validos.each do |v|
      @u.y = v
      assert @u.valid?, "#{v} no pasa la validación por #{@u.errors.messages}"
    end

    invalidos.each do |v|
      @u.y = v
      assert @u.invalid?, "#{v} no pasa la validación por #{@u.errors.messages}"
    end
  end

  test "las coordenadas deberían estar en SRID 4326" do
    @u.x = 50
    @u.y = 50
    @u.save
    srid = @u.coordenadas.srid
    assert 4326 == srid, "#{srid} es un SRID incorrecto"
  end

  test "punto, x e y manejan coordenadas correctamente" do
    u = Ubicacion.new x: 22.1, y: 33.2
    assert_equal "22.1 33.2", u.punto
    assert 22.1 == u.x
    assert 33.2 == u.y
  end

  test "maneja las coordenadas negativas correctamente" do
    assert_equal Ubicacion.grados_a_decimal("-40 30"), -40.5
    assert_equal Ubicacion.grados_a_decimal("-179 50 30"), -179.841667
  end

  test "aproxima las coordenadas según mosaico-recorrido-aerofoto" do
    flunk "no implementado todavía"
    #u = Ubicacion.new mosaico: '3760-2-2'
    #assert_equal '-60,708333333 -36,083333333', u.aproximar
  end

  test "debería soportar proj4" do
    assert RGeo::CoordSys::Proj4::supported?
  end

  test "debería soportar GEOS" do
    assert RGeo::Geos::supported?
  end

  test "debería hacer alguna transformación" do
    ues = [ Ubicacion.transformar(22177, 4326, '7180428.8164', '7550269.2664'),
            Ubicacion.transformar(4326, 22177, '-54', '-26') ]

    ues.each do |u|
      assert u.present?
      assert u.x.present?
      assert u.y.present?
    end
  end

  test "debería transformar a WGS 84" do
    @u.transformar_a_wgs84!(22177, '7180428.8164', '7550269.2664')
    assert_equal 4326, @u.srid
    assert @u.coordenadas.present?, "No carga las coordenadas nuevas"
  end

end
