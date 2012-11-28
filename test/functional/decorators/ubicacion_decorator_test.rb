# encoding: utf-8
require './test/test_helper'

class UbicacionDecoratorTest < ActionController::TestCase

  def setup
    @lugar = build_stubbed :ubicacion, x: '-35.0', y: '-35.0'
  end

  test "debería devolver coordenadas por default si no hay usuario logueado" do
    assert_equal 4326, UbicacionDecorator.decorate(@lugar).srid
  end

  # TODO Averiguar por qué falla el test pero anda el código
  test "debería devolver las coordenadas proyectadas según las preferencias" do
    @usuario = loguearse_como :administrador
    @usuario.srid = 22195
    assert_equal @usuario.srid, UbicacionDecorator.decorate(@lugar).srid

    proyeccion = Ubicacion.transformar(@lugar.srid, @usuario.srid, @lugar.x, @lugar.y)
    assert_equal proyeccion.x, UbicacionDecorator.decorate(@lugar).x, "x no coincide con la preferencia"
    assert_equal proyeccion.y, UbicacionDecorator.decorate(@lugar).y, "y no coincide con la preferencia"
  end

end
