require './test/test_helper'

describe Ficha do
  subject { build(:ficha) }

  it 'es válida' do
    subject.must_be :valid?
  end

  it 'requiere nombre' do
    build(:ficha, nombre: nil).wont_be :valid?
  end

  it 'requiere identificador' do
    build(:ficha, identificador: nil).wont_be :valid?
  end
end
