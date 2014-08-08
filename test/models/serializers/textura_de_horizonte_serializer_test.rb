# encoding: utf-8
require './test/test_helper'

class TexturaDeHorizonteSerializerTest < ActiveSupport::TestCase
  test 'al serializar devuelve la clase' do
    textura = TexturaDeHorizonte.first
    serializer = TexturaDeHorizonteSerializer.new(textura)

    serializer.serializable_hash.must_equal textura.clase
  end
end
