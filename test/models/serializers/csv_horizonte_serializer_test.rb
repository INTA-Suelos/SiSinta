require 'test_helper'

class CSVHorizonteSerializerTest < ActiveSupport::TestCase
  subject { CSVHorizonteSerializer.new horizonte }
  let(:horizonte) { create(:perfil_completo).horizontes.first }

  describe '#to_csv' do
    it 'renders every value by default' do
      # FIXME Test every possible attribute
      skip
    end

    it 'renders specific values' do
      skip
    end

    it 'renders values in order' do
      skip
    end
  end
end
