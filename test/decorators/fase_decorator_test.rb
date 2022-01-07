require 'test_helper'

class FaseDecoratorTest < ActiveSupport::TestCase
  subject { FaseDecorator.new fase }
  let(:fase) { build :fase }

  describe '#nombre' do
    it 'devuelve el nombre del objeto decorado' do
      _(subject.nombre).must_equal fase.nombre
    end

    it 'devuelve una cadena vacía sin objeto decorado' do
      _(FaseDecorator.new(nil).nombre).must_equal ''
    end
  end
end
