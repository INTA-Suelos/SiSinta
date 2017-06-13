require 'test_helper'

describe GeojsonCollectionSerializer do
  subject { GeojsonCollectionSerializer.new perfiles }
  let(:perfiles) { [create(:perfil_para_geojson)] }

  it 'es una colección de features' do
    geojson = subject.as_json

    geojson['type'].must_equal 'FeatureCollection'
    geojson['features'].size.must_equal 1
    geojson['features'].first['type'].must_equal 'Feature'
  end

  it 'decora los perfiles antes de serializar' do
    decorame = Minitest::Mock.new.expect :decorate, subject.object.first.decorate

    subject.stub :object, [decorame] do
      subject.features

      decorame.verify
    end
  end
end
