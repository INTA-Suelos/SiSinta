require 'test_helper'

class ClaseDeCapacidadSerializerTest < ActiveSupport::TestCase
  subject { ClaseDeCapacidadSerializer.new(clase) }
  let(:clase) { build_stubbed :clase_de_capacidad }

  it 'al serializar devuelve el código' do
    _(subject.serializable_hash).must_equal clase.codigo
  end
end
