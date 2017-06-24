require 'test_helper'

class AdhesividadTest < ActiveSupport::TestCase
  subject { create :adhesividad }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
      build_stubbed(:adhesividad).must_be :valid?
    end

    it 'requiere valor' do
      build_stubbed(:adhesividad, valor: nil).wont_be :valid?
    end

    it 'require valor único' do
      build_stubbed(:adhesividad, valor: subject.valor).wont_be :valid?
    end

    it 'permite valores duplicados en diferentes locales' do
      valor_es = subject.valor

      Globalize.with_locale :en do
        build_stubbed(:adhesividad, valor: valor_es).must_be :valid?
      end
    end
  end

  describe 'asociaciones' do
    let(:consistencia) { create :consistencia, adhesividad: subject }

    it 'se recorre en ambos sentidos' do
      consistencia.adhesividad.must_equal subject

      subject.consistencias.first.must_equal consistencia
    end
  end
end
