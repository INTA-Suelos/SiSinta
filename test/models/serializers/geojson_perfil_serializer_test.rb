# encoding: utf-8
require './test/test_helper'

class GeojsonPerfilSerializerTest < ActiveSupport::TestCase
  # Para los _url
  include Rails.application.routes.url_helpers

  setup do
    @perfil = create(:perfil_para_geojson).decorate
    @serializador = GeojsonPerfilSerializer.new @perfil
    @geojson = @serializador.as_json
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
    assert_equal perfil_url(@perfil), @geojson.properties['url']
  end

  test 'incluye el nombre anidado de la serie' do
    assert_equal @perfil.nombre, @geojson.properties['serie']['nombre']
  end

  test 'incluye un link anidado a la serie' do
    assert_equal serie_url(@perfil.serie), @geojson.properties['serie']['url']
  end

  test 'si el perfil no tiene serie el geojson no tiene serie' do
    @geojson = GeojsonPerfilSerializer.new(
      create(:perfil_para_geojson, serie: nil).decorate
    ).as_json

    assert_nil @geojson.properties['serie']
  end
end
