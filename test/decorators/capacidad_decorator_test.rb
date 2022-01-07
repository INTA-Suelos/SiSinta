require 'test_helper'

class CapacidadDecoratorTest < ActiveSupport::TestCase
  subject { CapacidadDecorator.new capacidad }
  let(:capacidad) { build :capacidad }

  describe '#to_s' do
    it 'sin subclases es una cadena vacía' do
      _(subject.to_s).must_equal ''
    end

    it 'devuelve la lista de subclases' do
      capacidad.subclases.build codigo: 'a'
      capacidad.subclases.build codigo: 'b'

      _(subject.to_s).must_equal 'a b'
    end
  end
end
