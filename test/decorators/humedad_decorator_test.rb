require 'test_helper'

class HumedadDecoratorTest < ActiveSupport::TestCase
  subject { HumedadDecorator.new humedad }
  let(:humedad) { build :humedad }

  describe '#to_s' do
    it 'sin subclases es una cadena vacía' do
      _(subject.to_s).must_equal ''
    end

    it 'devuelve la lista de subclases' do
      humedad.subclases.build valor: 'a'
      humedad.subclases.build valor: 'b'

      _(subject.to_s).must_equal 'a b'
    end
  end
end
