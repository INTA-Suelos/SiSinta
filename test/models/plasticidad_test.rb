require './test/test_helper'

class PlasticidadTest < ActiveSupport::TestCase
  subject { build_stubbed(:plasticidad) }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere valor' do
      _(build_stubbed(:plasticidad, valor: nil)).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :plasticidad }
    let(:consistencia) { create :consistencia, plasticidad: subject }

    it 'se recorre en ambos sentidos' do
      _(consistencia.plasticidad).must_equal subject

      _(subject.consistencias.first).must_equal consistencia
    end
  end
end
