require './test/test_helper'

describe Ficha do
  subject { build(:ficha) }
  let(:existente) { create(:ficha) }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere nombre' do
      build(:ficha, nombre: nil).wont_be :valid?
    end

    it 'requiere identificador' do
      build(:ficha, identificador: nil).wont_be :valid?
    end

    it 'nombre debe ser único' do
      build(:ficha, nombre: existente.nombre).wont_be :valid?
    end

    it 'identificador debe ser único' do
      build(:ficha, identificador: existente.identificador).wont_be :valid?
    end
  end
end
