# encoding: utf-8
require 'test_helper'

class UbicacionDecoratorTest < ActionController::TestCase

  def setup
    @juan = Usuario.find_by_nombre('Administrador')
    @juan.srid = 22195
    ApplicationController.new.set_current_view_context
    sign_in @juan
  end

  test "debería devolver las coordenadas proyectadas según las preferencias" do
    @lugar = Ubicacion.create(srid: 4326, x: '-35.0', y: '-35.0')
    assert_equal @juan, UbicacionDecorator.decorate(@lugar).srid

    proyeccion = Ubicacion.transformar(@lugar.srid, @juan.srid, @lugar.x, @lugar.y)
    assert_equal proyeccion.x, UbicacionDecorator.decorate(@lugar).x, "x no coincide con la preferencia"
    assert_equal proyeccion.y, UbicacionDecorator.decorate(@lugar).y, "y no coincide con la preferencia"
  end

end
