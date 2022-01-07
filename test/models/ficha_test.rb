require './test/test_helper'

describe Ficha do
  subject { build(:ficha) }
  let(:existente) { create(:ficha) }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere nombre' do
      _(build(:ficha, nombre: nil)).wont_be :valid?
    end

    it 'requiere identificador' do
      _(build(:ficha, identificador: nil)).wont_be :valid?
    end

    it 'nombre debe ser único' do
      _(build(:ficha, nombre: existente.nombre)).wont_be :valid?
    end

    it 'identificador debe ser único' do
      _(build(:ficha, identificador: existente.identificador)).wont_be :valid?
    end
  end
end
