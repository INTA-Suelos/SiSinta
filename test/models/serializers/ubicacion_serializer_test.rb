require './test/test_helper'

class UbicacionSerializerTest < ActiveSupport::TestCase
  subject { UbicacionSerializer.new(ubicacion) }
  let(:ubicacion) { create(:ubicacion, :con_perfil, :con_coordenadas) }

  it 'no serializa coordenadas juntas' do
    subject.serializable_hash.keys.include?(:coordenadas).wont_equal true
  end

  it 'serializa latitud y longitud por separado' do
    hash = subject.serializable_hash

    hash.keys.include?(:latitud).must_equal true
    hash.keys.include?(:longitud).must_equal true

    hash[:latitud].wont_be :nil?
    hash[:longitud].wont_be :nil?

    hash[:latitud].must_equal ubicacion.latitud
    hash[:longitud].must_equal ubicacion.longitud
  end
end
