require './test/test_helper'

class ClaseDeErosionTest < ActiveSupport::TestCase
  subject { build :clase_de_erosion }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build(:clase_de_erosion, valor: nil).wont_be :valid?
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
