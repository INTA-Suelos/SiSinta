require './test/test_helper'

class UbicacionSerializerTest < ActiveSupport::TestCase
  subject { UbicacionSerializer.new(ubicacion) }
  let(:ubicacion) { create(:ubicacion, :con_perfil, :con_coordenadas) }

  it 'no serializa coordenadas juntas' do
    _(subject.serializable_hash.keys.include?(:coordenadas)).wont_equal true
  end

  it 'serializa latitud y longitud por separado' do
    hash = subject.serializable_hash

    _(hash.keys.include?(:latitud)).must_equal true
    _(hash.keys.include?(:longitud)).must_equal true

    _(hash[:latitud]).wont_be :nil?
    _(hash[:longitud]).wont_be :nil?

    _(hash[:latitud]).must_equal ubicacion.latitud
    _(hash[:longitud]).must_equal ubicacion.longitud
  end
end
