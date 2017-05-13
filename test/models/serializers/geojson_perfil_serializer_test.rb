require 'test_helper'

describe GeojsonPerfilSerializer do
  include Rails.application.routes.url_helpers

  subject { GeojsonPerfilSerializer.new perfil }
  let(:perfil) { create(:perfil_para_geojson).decorate }
  let(:geojson) { subject.as_json }

  describe 'properties' do
    it 'incluye el id del perfil' do
      geojson.properties['id'].must_equal perfil.id
    end

    it 'incluye el número del perfil' do
      geojson.properties['numero'].must_equal perfil.numero
    end

    it 'incluye la fecha del perfil' do
      geojson.properties['fecha'].must_equal perfil.fecha
    end

    it 'incluye la clase del perfil' do
      geojson.properties['clase'].must_equal perfil.clase
    end

    it 'incluye un link al perfil' do
      geojson.properties['url'].must_equal perfil_url(perfil)
    end

    describe 'serie' do
      it 'incluye el nombre de la serie' do
        geojson.properties['serie']['nombre'].must_equal perfil.nombre
      end

      it 'incluye un link a la serie' do
        geojson.properties['serie']['url'].must_equal serie_url(perfil.serie)
      end

      it 'si el perfil no tiene serie el geojson no tiene serie' do
        geojson = GeojsonPerfilSerializer.new(
          create(:perfil_para_geojson, serie: nil).decorate
        ).as_json

        geojson.properties['serie'].must_be :nil?
      end
    end
  end
end
