# -*- encoding : utf-8 -*-
require 'test_helper'

class FormatoDeCoordenadasTest < ActiveSupport::TestCase

  test "debería devolver el formato por srid" do
    assert_equal FormatoDeCoordenadas.where(srid: 4326).first, FormatoDeCoordenadas.srid(4326)
    assert_equal FormatoDeCoordenadas.where(srid: 22177).first, FormatoDeCoordenadas.srid(22177)
  end

  test "debería cargar la fábrica de RGeo siempre" do
    assert_kind_of RGeo::Geos::Factory, FormatoDeCoordenadas.first.fabrica
  end

end
