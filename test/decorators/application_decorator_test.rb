# encoding: utf-8
require './test/test_helper'

describe ApplicationDecorator do
  describe '#to_array' do
    subject { PerfilDecorator.decorate(build(:perfil)) }

    it 'convierte el modelo a Array' do
      _(subject.to_array).must_be_instance_of Array
    end
  end
end
