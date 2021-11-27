require './test/test_helper'

class ErosionTest < ActiveSupport::TestCase
  describe 'validaciones' do
    subject { build :erosion }

    it 'es válido' do
      _(subject).must_be :valid?
    end

    it 'requiere el perfil' do
      _(build_stubbed(:erosion, perfil: nil)).wont_be :valid?
    end

    it 'si subclase es `acumulación` clase debe estar en blanco' do
      subject.subclase = build :subclase_de_erosion, valor: 'acumulación'
      subject.clase=  build :clase_de_erosion

      _(subject).wont_be :valid?
    end
  end
end
