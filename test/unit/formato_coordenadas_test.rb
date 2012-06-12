# -*- encoding : utf-8 -*-
require 'test_helper'

class FormatoCoordenadasTest < ActiveSupport::TestCase

  test "debería devolver el formato por srid" do
    assert_equal FormatoCoordenadas.where(valor2: '4326').first, FormatoCoordenadas.srid(4326)
  end

  test "debería cargar la fábrica de RGeo" do
    assert_kind_of RGeo::Geos::Factory, FormatoCoordenadas.first.fabrica
  end

end
