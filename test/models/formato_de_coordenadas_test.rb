# encoding: utf-8
require './test/test_helper'

class FormatoDeCoordenadasTest < ActiveSupport::TestCase

  test "debería devolver el formato por srid" do
    assert_equal FormatoDeCoordenadas.where(srid: 4326).first,
                  FormatoDeCoordenadas.srid(4326)
    assert_equal FormatoDeCoordenadas.where(srid: 4326).first,
                  FormatoDeCoordenadas.srid('4326')
    assert_equal FormatoDeCoordenadas.where(srid: 22177).first,
                  FormatoDeCoordenadas.srid(22177)
    assert_equal FormatoDeCoordenadas.where(srid: 22177).first,
                  FormatoDeCoordenadas.srid('22177')
  end

  test "debería cargar la fábrica de RGeo siempre" do
    assert FormatoDeCoordenadas.first.fabrica.present?
    assert FormatoDeCoordenadas.last.fabrica.present?
  end

end
