# encoding: utf-8
require './test/test_helper'

class FaseDecoratorTest < Draper::TestCase
  test 'si decora nil nombre es una cadena vacía' do
    assert_equal '', FaseDecorator.new(nil).nombre
  end
end
