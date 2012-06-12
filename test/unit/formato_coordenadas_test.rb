# -*- encoding : utf-8 -*-
require 'test_helper'

class FormatoCoordenadasTest < ActiveSupport::TestCase

  test "debería devolver el formato por srid" do
    assert_equal FormatoCoordenadas.where(valor2: '4326').first, FormatoCoordenadas.srid(4326)
    assert_equal FormatoCoordenadas.where(valor2: '22177').first, FormatoCoordenadas.srid('22177')
  end

  test "debería cargar la fábrica de RGeo siempre" do
    assert_kind_of RGeo::Geos::Factory, FormatoCoordenadas.first.fabrica
  end

end
