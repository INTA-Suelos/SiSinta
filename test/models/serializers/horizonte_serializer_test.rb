require './test/test_helper'

class HorizonteSerializerTest < ActiveSupport::TestCase
  subject { HorizonteSerializer.new(horizonte_con_tipo ) }
  let(:horizonte_con_tipo) { create :horizonte, tipo: 'algún tipo' }

  it 'serializa tipo como :horizonte' do
    _(subject.serializable_hash[:horizonte]).must_equal 'algún tipo'
  end
end
