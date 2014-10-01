# encoding: utf-8
require './test/test_helper'

class GrupoDecoratorTest < Draper::TestCase
  test 'si decora nil descripción es una cadena vacía' do
    assert_equal '', GrupoDecorator.new(nil).descripcion
  end
end
