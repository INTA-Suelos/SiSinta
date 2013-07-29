# encoding: utf-8
require './test/test_helper'

class PerfilDecoratorTest < Draper::TestCase
  def setup
    @perfil = build_stubbed(:perfil)
  end

  test "decora la ubicación" do
    @perfil.ubicacion = create(:ubicacion)
    assert_kind_of UbicacionDecorator, PerfilDecorator.decorate(@perfil).ubicacion
  end

  test "usa día/mes/año para la fecha" do
    @perfil.fecha = Date.new
    assert_equal Date.new.to_s(:dma), PerfilDecorator.decorate(@perfil).fecha
  end
end
