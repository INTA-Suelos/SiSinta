# encoding: utf-8
require './test/test_helper'

class UbicacionTest < ActiveSupport::TestCase

  setup do
    @atributos = {}
    @u = build_stubbed(:ubicacion)
    @x = -61.85
    @y = -34.1725
    @c = create(:ubicacion, x: @x, y: @y)
  end

  test "no carga la ubicación sin perfil" do
    assert Ubicacion.new(@atributos).invalid?, "una ubicación sin perfil es válida"
    assert @u.valid?, "una ubicación sólo con perfil es válida"
  end

  test "no guarda un punto mal formado" do
    assert Ubicacion.new(:coordenadas => 'rms').invalid?, "permite guardar 'rms' como latitud/longitud"
  end

  test "la longitud (x) sólo está entre #{SiSINTA::Application.config.rango_x}" do
    validos =   [-180, -180.0000, "-179° 60' 0\"", 0, "180°", -179.99999999, 180]
    invalidos = [-181, 180.000001, "-179° 60' 1\"", "180° 1'", -250]

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

  test "la latitud (y) está entre #{SiSINTA::Application.config.rango_y}" do
    validos =   [-90, -90.0000, "24° 70'", 0, -89.99999999, 90, "89° 59' 59\"" ]
    invalidos = [90.000001, -250, "89° 60' 30\""]

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

  test "las coordenadas están en SRID 4326" do
    srid = @c.coordenadas.srid
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
    skip "no implementado todavía"
    #u = build_stubbed(:ubicacion, :vieja_escuela)
    #assert_equal '-60,708333333 -36,083333333', u.aproximar
  end

  test "soporta proj4" do
    assert RGeo::CoordSys::Proj4::supported?
  end

  test "soporta GEOS" do
    assert RGeo::Geos::supported?
  end

  test "hace alguna transformación" do
    ues = [ Ubicacion.transformar(22177, 4326, '7180428.8164', '7550269.2664'),
            Ubicacion.transformar(4326, 22177, '-54', '-26') ]

    ues.each do |u|
      assert u.present?
      assert u.x.present?
      assert u.y.present?
    end
  end

  test "transformar a WGS 84" do
    @u.transformar_a_wgs84!(22177, '7180428.8164', '7550269.2664')
    assert_equal 4326, @u.srid
    assert @u.coordenadas.present?, "No carga las coordenadas nuevas"
  end

  test "(lat,lon) corresponde a (y,x)" do
    assert_equal @c.latitud, @y
    assert_equal @c.longitud, @x
    assert_equal @c.coordenadas.x, @x
    assert_equal @c.coordenadas.y, @y
  end

  test "convierte a GeoJSON" do
    feature = RGeo::GeoJSON::EntityFactory.instance.feature @c.coordenadas
    assert_respond_to feature, :geometry, "No responde a 'geometry'"
    geojson = RGeo::GeoJSON.encode(feature)
    assert_equal Hash.new, geojson["properties"]
    assert_equal "Feature", geojson["type"]
    assert_equal "Point", geojson["geometry"]["type"]
    assert_equal [-61.85, -34.1725], geojson["geometry"]["coordinates"]
  end

  test "elimina las coordenadas con datos en blanco" do
    assert_not_nil @c.coordenadas
    @c.x, @c.y = "", ""
    @c.save
    assert_nil @c.coordenadas
    @c.x, @c.y = nil, nil
    @c.save
    assert_nil @c.coordenadas
    @c.x = nil
    @c.save
    assert_nil @c.coordenadas
  end
end
