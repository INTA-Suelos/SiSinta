require './test/test_helper'

class SubclaseDeErosionTest < ActiveSupport::TestCase
  subject { build :subclase_de_erosion }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build(:subclase_de_erosion, valor: nil).wont_be :valid?
    end
  end

  it 'sabe si es una acumulación' do
    subject.wont_be :acumulacion?
    build(:subclase_de_erosion, valor: 'acumulación').must_be :acumulacion?
  end
end
