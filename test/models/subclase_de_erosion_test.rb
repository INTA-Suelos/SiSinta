require 'test_helper'

class SubclaseDeErosionTest < ActiveSupport::TestCase
  subject { build :subclase_de_erosion }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere valor' do
      _(build(:subclase_de_erosion, valor: nil)).wont_be :valid?
    end
  end

  it 'sabe si es una acumulación' do
    _(subject).wont_be :acumulacion?
    _(build(:subclase_de_erosion, valor: 'acumulación')).must_be :acumulacion?
  end

  describe 'asociaciones' do
    subject { create :subclase_de_erosion }
    let(:erosion) { create :erosion, subclase: subject }

    it 'se recorre en ambos sentidos' do
      _(erosion.subclase).must_equal subject

      _(subject.erosiones.first).must_equal erosion
    end
  end
end
