# encoding: utf-8
require './test/test_helper'

describe PerfilDecorator do
  let(:perfil) { build_stubbed :perfil, publico: true }
  let(:decorador) { PerfilDecorator.decorate perfil }

  describe 'asociaciones' do
    it 'decora la ubicación' do
      perfil.ubicacion = build(:ubicacion)

      decorador.ubicacion.must_be_kind_of UbicacionDecorator
    end

    it 'decora grupo nulo' do
      decorador.grupo.object.must_be_nil

      decorador.grupo.must_be_instance_of GrupoDecorator
    end

    it 'decora fase nula' do
      decorador.fase.object.must_be_nil

      decorador.fase.must_be_instance_of FaseDecorator
    end
  end

  describe '#fecha' do
    it 'está en formato día/mes/año' do
      perfil.fecha = Date.new 1999, 5, 29

      decorador.fecha.must_equal '29/05/1999'
    end
  end

  describe '#clase' do
    it 'es fase y grupo concatenados' do
      perfil.build_grupo descripcion: 'grupo lindo'
      perfil.build_fase nombre: 'fase buena'

      decorador.clase.must_equal 'grupo lindo fase buena'
    end

    it 'es una cadena vacía sin fase ni grupo' do
      decorador.clase.must_equal ''
    end

    it 'no está disponible para los perfiles privados' do
      perfil.publico = false
      h = Minitest::Mock.new.expect :can?, false, [:read, perfil]

      decorador.stub :h, h do
        decorador.clase.must_equal 'No disponible'
      end
    end

    it 'está disponible para los perfiles privados si el usuario tiene acceso' do
      perfil.publico = false
      h = Minitest::Mock.new.expect :can?, true, [:read, perfil]

      decorador.stub :h, h do
        decorador.clase.wont_equal 'No disponible'
      end
    end
  end

  describe '#etiquetas' do
    it 'devuelve una cadena vacía si no hay' do
      perfil.etiquetas.must_be :empty?

      decorador.etiquetas.must_equal ''
    end

    it 'devuelve las etiquetas unidas con ,' do
      perfil.etiqueta_list.add 'uno', 'dos'

      decorador.etiquetas.must_equal 'uno, dos'
    end
  end

  describe '#reconocedores' do
    it 'devuelve una cadena vacía si no hay' do
      perfil.reconocedores.must_be :empty?

      decorador.reconocedores.must_equal ''
    end

    it 'devuelve las reconocedores unidas con ,' do
      perfil.reconocedor_list.add 'uno', 'dos'

      decorador.reconocedores.must_equal 'uno, dos'
    end
  end
end
