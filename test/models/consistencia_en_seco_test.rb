require './test/test_helper'

class ConsistenciaEnSecoTest < ActiveSupport::TestCase
  subject { build_stubbed(:consistencia_en_seco) }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build_stubbed(:consistencia_en_seco, valor: nil).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :consistencia_en_seco }
    let(:consistencia) { create :consistencia, en_seco: subject }

    it 'se recorre en ambos sentidos' do
      consistencia.en_seco.must_equal subject

      subject.consistencias.first.must_equal consistencia
    end
  end
end
