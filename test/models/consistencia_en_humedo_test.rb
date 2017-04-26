require './test/test_helper'

class ConsistenciaEnHumedoTest < ActiveSupport::TestCase
  subject { build_stubbed(:consistencia_en_humedo) }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build_stubbed(:consistencia_en_humedo, valor: nil).wont_be :valid?
    end
  end
end
