# encoding: utf-8
require './test/test_helper'

describe UbicacionDecorator do
  subject { UbicacionDecorator.decorate lugar, context: { usuario: usuario } }
  let(:lugar) { build_stubbed :ubicacion, x: '-35.0', y: '-35.0' }
  let(:usuario) { build_stubbed :usuario, config: { srid: 22195 } }

  describe 'sin estar logueado' do
    it 'devuelve coordenadas por default' do
      # 'Stub' de método inexistente (singleton method)
      # Necesario porque el decorador busca en current_usuario si no hay contexto
      def helpers.current_usuario
        nil
      end

      UbicacionDecorator.decorate(lugar).srid.must_equal 4326
    end
  end

  describe 'estando logueado' do
    before do
      create :formato_de_coordenadas, srid: usuario.srid
      create :formato_de_coordenadas, srid: lugar.srid
    end

    it 'devuelve las coordenadas proyectadas según las preferencias' do
      subject.srid.must_equal usuario.srid
    end

    it 'proyecta x e y de acuerdo al srid preferido' do
      proyeccion = Ubicacion.transformar(lugar.srid, usuario.srid, lugar.x, lugar.y)

      subject.x.must_equal Ubicacion.redondear(proyeccion.x)
      subject.y.must_equal Ubicacion.redondear(proyeccion.y)
    end
  end
end
