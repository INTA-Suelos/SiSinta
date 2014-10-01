# encoding: utf-8
require './test/test_helper'

class GeojsonCollectionSerializerTest < ActiveSupport::TestCase
  test 'es una colección de features' do
    serializador = GeojsonCollectionSerializer.new [ create(:perfil_para_geojson) ]

    geojson = serializador.as_json

    assert_equal 'FeatureCollection', geojson['type']
    assert_equal 1, geojson['features'].size
    assert_equal 'Feature', geojson['features'].first['type']
  end
end
