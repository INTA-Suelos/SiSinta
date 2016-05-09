# encoding: utf-8
require './test/test_helper'

describe UbicacionDecorator do
  let(:lugar) { build_stubbed :ubicacion, x: '-35.0', y: '-35.0' }
  let(:usuario) { build_stubbed :usuario, config: { srid: 22195 } }
  let(:lugar_decorado) { UbicacionDecorator.decorate lugar, context: { usuario: usuario } }

  it 'devuelve coordenadas por default si no hay usuario logueado' do
    # 'Stub' de método inexistente (singleton method)
    # Necesario porque el decorador busca en current_usuario si no hay contexto
    def helpers.current_usuario
      nil
    end

    UbicacionDecorator.decorate(lugar).srid.must_equal 4326
  end

  it 'devuelve las coordenadas proyectadas según las preferencias' do
    lugar_decorado.srid.must_equal usuario.srid
  end

  it 'proyecta x e y de acuerdo al srid preferido' do
    proyeccion = Ubicacion.transformar(lugar.srid, usuario.srid, lugar.x, lugar.y)

    lugar_decorado.x.must_equal Ubicacion.redondear(proyeccion.x)
    lugar_decorado.y.must_equal Ubicacion.redondear(proyeccion.y)
  end
end
