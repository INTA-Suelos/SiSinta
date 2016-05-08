require './test/test_helper'

class GeojsonPerfilSerializerTest < ActiveSupport::TestCase
  # Para testear que incluya links
  include Rails.application.routes.url_helpers

  subject { GeojsonPerfilSerializer.new perfil }
  let(:perfil) { create(:perfil_para_geojson).decorate }
  let(:geojson) { subject.as_json }

  it 'incluye el id del perfil' do
    assert_equal perfil.id, geojson.properties['id']
  end

  it 'incluye el número del perfil' do
    assert_equal perfil.numero, geojson.properties['numero']
  end

  it 'incluye la fecha del perfil' do
    assert_equal perfil.fecha, geojson.properties['fecha']
  end

  it 'incluye la clase del perfil' do
    assert_equal perfil.clase, geojson.properties['clase']
  end

  it 'incluye un link al perfil' do
    assert_equal perfil_url(perfil), geojson.properties['url']
  end

  it 'incluye el nombre anidado de la serie' do
    assert_equal perfil.nombre, geojson.properties['serie']['nombre']
  end

  it 'incluye un link anidado a la serie' do
    assert_equal serie_url(perfil.serie), geojson.properties['serie']['url']
  end

  it 'si el perfil no tiene serie el geojson no tiene serie' do
    geojson = GeojsonPerfilSerializer.new(
      create(:perfil_para_geojson, serie: nil).decorate
    ).as_json

    assert_nil geojson.properties['serie']
  end
end
