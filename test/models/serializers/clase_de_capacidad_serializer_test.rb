require './test/test_helper'

class ClaseDeCapacidadSerializerTest < ActiveSupport::TestCase
  subject { ClaseDeCapacidadSerializer.new(clase) }
  let(:clase) { ClaseDeCapacidad.first }

  it 'al serializar devuelve el código' do
    subject.serializable_hash.must_equal clase.codigo
  end
end
