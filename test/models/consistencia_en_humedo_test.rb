require './test/test_helper'

class ConsistenciaEnHumedoTest < ActiveSupport::TestCase
  subject { build_stubbed(:consistencia_en_humedo) }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere valor' do
      _(build_stubbed(:consistencia_en_humedo, valor: nil)).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :consistencia_en_humedo }
    let(:consistencia) { create :consistencia, en_humedo: subject }

    it 'se recorre en ambos sentidos' do
      _(consistencia.en_humedo).must_equal subject

      _(subject.consistencias.first).must_equal consistencia
    end
  end
end
