require 'test_helper'

class ClaseDeErosionTest < ActiveSupport::TestCase
  subject { create :clase_de_erosion }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
      build_stubbed(:clase_de_erosion).must_be :valid?
    end

    it 'requiere valor' do
      build_stubbed(:clase_de_erosion, valor: nil).wont_be :valid?
    end

    it 'requiere valor único' do
      build_stubbed(:clase_de_erosion, valor: subject.valor).wont_be :valid?
    end

    it 'permite valores duplicados en diferentes locales' do
      valor_es = subject.valor

      Globalize.with_locale :en do
        build_stubbed(:clase_de_erosion, valor: valor_es).must_be :valid?
      end
    end
  end

  describe 'asociaciones' do
    subject { create :clase_de_erosion }
    let(:erosion) { create :erosion, clase: subject }

    it 'se recorre en ambos sentidos' do
      erosion.clase.must_equal subject

      subject.erosiones.first.must_equal erosion
    end
  end
end
