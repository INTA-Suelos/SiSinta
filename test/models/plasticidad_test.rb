require './test/test_helper'

class PlasticidadTest < ActiveSupport::TestCase
  subject { build_stubbed(:plasticidad) }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build_stubbed(:plasticidad, valor: nil).wont_be :valid?
    end
  end
end
