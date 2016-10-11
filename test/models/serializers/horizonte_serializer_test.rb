require './test/test_helper'

class HorizonteSerializerTest < ActiveSupport::TestCase
  subject { HorizonteSerializer.new(clase) }
  let(:clase) { create :horizonte }

  it 'serializa tipo como :clase' do
    subject.serializable_hash[:clase].must_equal clase.tipo
  end
end
