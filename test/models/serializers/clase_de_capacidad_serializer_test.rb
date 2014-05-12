# encoding: utf-8
require './test/test_helper'

class ClaseDeCapacidadSerializerTest < ActiveSupport::TestCase
  test 'al serializar devuelve el código' do
    clase = ClaseDeCapacidad.first
    serializer = ClaseDeCapacidadSerializer.new(clase)

    serializer.serializable_hash.must_equal clase.codigo
  end
end
