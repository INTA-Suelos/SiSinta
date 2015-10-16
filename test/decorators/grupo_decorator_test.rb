# encoding: utf-8
require './test/test_helper'

describe GrupoDecorator do
  subject { build(:grupo) }

  describe '#descripcion' do
    it 'devuelve la descripción del objeto decorado' do
      GrupoDecorator.new(subject).descripcion.must_equal subject.descripcion
    end

    it 'devuelve una cadena vacía sin objeto decorado' do
      GrupoDecorator.new(nil).descripcion.must_equal ''
    end
  end
end
