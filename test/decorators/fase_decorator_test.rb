require './test/test_helper'

describe FaseDecorator do
  subject { build(:fase) }

  describe '#nombre' do
    it 'devuelve el nombre del objeto decorado' do
      FaseDecorator.new(subject).nombre.must_equal subject.nombre
    end

    it 'devuelve una cadena vacía sin objeto decorado' do
      FaseDecorator.new(nil).nombre.must_equal ''
    end
  end
end
