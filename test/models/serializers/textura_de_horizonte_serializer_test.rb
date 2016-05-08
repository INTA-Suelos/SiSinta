# encoding: utf-8
require './test/test_helper'

class TexturaDeHorizonteSerializerTest < ActiveSupport::TestCase
  subject { TexturaDeHorizonteSerializer.new(textura) }
  let(:textura) { TexturaDeHorizonte.first }

  it 'al serializar devuelve la clase' do
    subject.serializable_hash.must_equal textura.clase
  end
end
