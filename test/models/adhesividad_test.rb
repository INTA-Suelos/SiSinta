require 'test_helper'

class AdhesividadTest < ActiveSupport::TestCase
  subject { build_stubbed :adhesividad }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build_stubbed(:adhesividad, valor: nil).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :adhesividad }
    let(:consistencia) { create :consistencia, adhesividad: subject }

    it 'se recorre en ambos sentidos' do
      consistencia.adhesividad.must_equal subject

      subject.consistencias.first.must_equal consistencia
    end
  end
end
