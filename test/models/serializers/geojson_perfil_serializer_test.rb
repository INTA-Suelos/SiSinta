# encoding: utf-8
require './test/test_helper'

class GeojsonPerfilSerializerTest < ActiveSupport::TestCase
  setup do
    @perfil = create(:perfil_para_geojson).decorate
    @serializador = GeojsonPerfilSerializer.new @perfil
    @geojson = @serializador.as_json
  end

  test 'incluye el nombre de la serie' do
    assert_equal @perfil.nombre, @geojson.properties['serie']
  end

  test 'incluye el id del perfil' do
    assert_equal @perfil.id, @geojson.properties['id']
  end

  test 'incluye el número del perfil' do
    assert_equal @perfil.numero, @geojson.properties['numero']
  end

  test 'incluye la fecha del perfil' do
    assert_equal @perfil.fecha, @geojson.properties['fecha']
  end

  test 'incluye la clase del perfil' do
    assert_equal @perfil.clase, @geojson.properties['clase']
  end

  test 'incluye un link al perfil' do
    skip
  end

  test 'incluye un link a la serie' do
    skip
  end
end
