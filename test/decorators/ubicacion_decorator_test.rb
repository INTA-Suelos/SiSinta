# encoding: utf-8
require './test/test_helper'

class UbicacionDecoratorTest < Draper::TestCase
  def setup
    @lugar = build_stubbed :ubicacion, x: '-35.0', y: '-35.0'
  end

  test "devuelve coordenadas por default si no hay usuario logueado" do
    # "Stub" de método inexistente (singleton method)
    def helpers.current_usuario
      nil
    end

    assert_equal 4326, UbicacionDecorator.decorate(@lugar).srid
  end

  test "devuelve las coordenadas proyectadas según las preferencias" do
    usuario = build_stubbed :usuario, config: { srid: 22195 }
    lugar_decorado = UbicacionDecorator.decorate(@lugar, context: { usuario: usuario })

    assert_equal usuario.srid, lugar_decorado.srid

    proyeccion = Ubicacion.transformar(@lugar.srid, usuario.srid, @lugar.x, @lugar.y)
    assert_equal Ubicacion.redondear(proyeccion.x), lugar_decorado.x,
      "x no coincide con la preferencia"
    assert_equal Ubicacion.redondear(proyeccion.y), lugar_decorado.y,
      "y no coincide con la preferencia"
  end
end
