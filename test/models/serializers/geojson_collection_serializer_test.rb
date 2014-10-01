# encoding: utf-8
require './test/test_helper'

class GeojsonCollectionSerializerTest < ActiveSupport::TestCase
  setup do
    @serializador = GeojsonCollectionSerializer.new [ create(:perfil_para_geojson) ]
  end

  test 'es una colección de features' do
    geojson = @serializador.as_json

    assert_equal 'FeatureCollection', geojson['type']
    assert_equal 1, geojson['features'].size
    assert_equal 'Feature', geojson['features'].first['type']
  end

  test 'decora los perfiles antes de serializar' do
    decorame = Minitest::Mock.new.expect :decorate, @serializador.object.first.decorate

    @serializador.stub :object, [decorame] do
      @serializador.features and decorame.verify
    end
  end
end
