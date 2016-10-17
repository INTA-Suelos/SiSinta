require './test/test_helper'

class ProvinciaSerializerTest < ActiveSupport::TestCase
  subject { ProvinciaSerializer.new provincia }
  let(:provincia) { build :provincia }

  it 'se serializa como su nombre' do
    subject.serializable_hash.must_equal provincia.nombre
  end
end
