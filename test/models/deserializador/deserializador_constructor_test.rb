# encoding: utf-8
require './test/test_helper'

describe Deserializador::Constructor do
  let(:perfil_nuevo) { build(:perfil_completo) }
  let(:csv) do
    CSV.parse CSVSerializer.new([perfil_nuevo]).as_csv(headers: true), headers: true
  end
  let(:perfil_existente) { create(:perfil_completo) }
  let(:perfil_actualizado) do
    Deserializador::Constructor.new(perfil_a_csv(perfil_existente), actualizar: true)
  end

  describe '#usuario' do
    let(:usuario) { create(:usuario) }

    it 'acepta un usuario' do
      perfil = Deserializador::Constructor.new(csv, usuario: usuario).construir

      _(perfil.usuario).must_equal usuario
    end

    it 'acepta un email' do
      perfil = Deserializador::Constructor.new(csv, usuario: usuario.email).construir

      _(perfil.usuario).must_equal usuario
    end

    it 'acepta nil' do
      perfil = Deserializador::Constructor.new(csv, usuario: nil).construir

      _(perfil.usuario).must_be_nil
    end

    it 'acepta nada' do
      perfil = Deserializador::Constructor.new(csv).construir

      _(perfil.usuario).must_be_nil
    end

    it 'no se puede sacar el usuario de un perfil existente' do
      _(perfil_existente.usuario).wont_be_nil

      perfil = Deserializador::Constructor.new(
        perfil_a_csv(perfil_existente), actualizar: true, usuario: nil
      ).construir

      _(perfil.usuario).wont_be_nil
    end
  end

  describe '#actualizar?' do
    it 'crea los datos por omisión' do
      Deserializador::Constructor.new(csv).actualizar?.must_equal false
    end

    it 'registra si hay que actualizar' do
      perfil_actualizado.actualizar?.must_equal true
    end
  end

  describe '#construir_perfil' do
    let(:datos_a_actualizar) { build(:perfil_completo, id: perfil_existente.id) }
    let(:actualizado) do
      Deserializador::Constructor.new(perfil_a_csv(datos_a_actualizar), actualizar: true)
    end

    it 'es nuevo por omisión' do
      Deserializador::Constructor.new(csv).construir_perfil.wont_be :persisted?
    end

    it 'si hay que actualizar carga el existente' do
      perfil = perfil_actualizado.construir_perfil

      perfil.must_be :persisted?
      perfil.must_equal perfil_existente
    end

    it 'actualiza los datos' do
      perfil = actualizado.construir

      %w{
        id numero profundidad_napa cobertura_vegetal
        material_original modal fecha vegetacion_o_cultivos observaciones
        relieve_id uso_de_la_tierra_id sal_id permeabilidad_id escurrimiento_id
        pendiente_id anegamiento_id drenaje_id posicion_id
      }.each do |atributo|
        perfil.send(atributo).must_equal datos_a_actualizar.send(atributo), "Falla #{atributo}"
      end
    end

    it 'no actualiza el usuario' do
      perfil = actualizado.construir

      perfil.usuario_id.wont_equal datos_a_actualizar.usuario_id
      perfil.usuario_id.must_equal perfil_existente.usuario_id
    end
  end

  describe '#construir_horizontes' do
    let(:perfil_creado) { Deserializador::Constructor.new(csv).construir }

    it 'son nuevos si el perfil es nuevo' do
      perfil_creado.horizontes.any?.must_equal true

      perfil_creado.horizontes.each do |horizonte|
        horizonte.wont_be :persisted?
      end
    end

    it 'son existentes si estamos actualizando' do
      perfil = perfil_actualizado.construir

      perfil.horizontes.any?.must_equal true
      perfil.horizontes.each do |horizonte|
        horizonte.must_be :persisted?
      end
    end

    it 'actualiza los datos' do
      flunk 'falta implementar'
    end
  end
end
