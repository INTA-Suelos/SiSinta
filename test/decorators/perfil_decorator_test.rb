# encoding: utf-8
require './test/test_helper'

class PerfilDecoratorTest < Draper::TestCase
  def setup
    @perfil = build_stubbed :perfil, publico: true
    @decorador = PerfilDecorator.decorate @perfil
  end

  test 'decora la ubicación' do
    @perfil.ubicacion = create(:ubicacion)

    assert_kind_of UbicacionDecorator, @decorador.ubicacion
  end

  test 'usa día/mes/año para la fecha' do
    @perfil.fecha = Date.new

    assert_equal Date.new.to_s(:dma), @decorador.fecha
  end

  test 'devuelve nil decorado para grupo nulo' do
    assert_instance_of GrupoDecorator, @decorador.grupo
    assert_nil @decorador.grupo.object
  end

  test 'devuelve nil decorado para fase nula' do
    assert_instance_of FaseDecorator, @decorador.fase
    assert_nil @decorador.fase.object
  end

  test 'sin fase ni grupo clase es una cadena vacía' do
    assert_equal '', @decorador.clase
  end

  test 'fase y grupo se concatenan simplemente para formar la clase' do
    @perfil.build_grupo descripcion: 'grupo lindo'
    @perfil.build_fase nombre: 'fase buena'

    assert_equal 'grupo lindo fase buena', @decorador.clase
  end

  test 'la clase no está disponible para los perfiles privados' do
    @perfil.publico = false
    h = Minitest::Mock.new.expect :can?, false, [:read, @perfil]

    @decorador.stub :h, h do
      assert_equal 'No disponible', @decorador.clase
    end
  end
end
