require './test/test_helper'

class TexturaSerializerTest < ActiveSupport::TestCase
  subject { TexturaSerializer.new(textura) }
  let(:textura) { create(:textura) }

  it 'al serializar devuelve la clase' do
    subject.serializable_hash.must_equal textura.clase
  end
end
