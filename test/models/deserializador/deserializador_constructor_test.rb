# encoding: utf-8
require './test/test_helper'

describe Deserializador::Constructor do
  let(:perfil_nuevo) { build(:perfil_completo) }
  let(:perfil_existente) { create(:perfil_completo) }
  let(:perfil_cambiado) do
    coso = create(:perfil_completo)
    coso.assign_attributes(
      id: perfil_existente.id, numero: 'único'
    )
    coso
  end

  let(:csv) { perfil_a_csv perfil_nuevo }
  let(:constructor_creador) do
    Deserializador::Constructor.new(csv)
  end
  let(:constructor_actualizador) do
    Deserializador::Constructor.new(perfil_a_csv(perfil_cambiado), actualizar: true)
  end

  let(:atributos_de_perfil) do
    %w{
      id numero profundidad_napa cobertura_vegetal
      material_original modal fecha vegetacion_o_cultivos observaciones
      relieve_id uso_de_la_tierra_id sal_id permeabilidad_id escurrimiento_id
      pendiente_id anegamiento_id drenaje_id posicion_id
    }
  end
  let(:atributos_de_horizonte) do
    %w{
      id profundidad_inferior profundidad_superior barnices co3 moteados ph
      raices tipo concreciones formaciones_especiales humedad textura_id
    }
  end
  let(:atributos_de_analitico) do
    %w{
      id registro humedad s t ph_pasta ph_h2o ph_kcl resistencia_pasta
      base_ca base_mg base_k base_na arcilla materia_organica_c
      materia_organica_n limo_2_20 limo_2_50 arena_muy_fina arena_fina
      arena_media arena_gruesa arena_muy_gruesa ca_co3 agua_15_atm
      agua_util conductividad h saturacion_t saturacion_s_h
      densidad_aparente profundidad_muestra agua_3_atm materia_organica_cn
    }
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
      constructor_creador.actualizar?.must_equal false
    end

    it 'registra si hay que actualizar' do
      constructor_actualizador.actualizar?.must_equal true
    end
  end

  describe '#construir_perfil' do
    it 'es nuevo por omisión' do
      constructor_creador.construir_perfil.wont_be :persisted?
    end

    it 'crea el perfil' do
      lambda do
        constructor_creador.construir_perfil.save.must_equal true
      end.must_change 'Perfil.count'
    end

    it 'si hay que actualizar carga el existente' do
      perfil = constructor_actualizador.construir_perfil

      perfil.must_be :persisted?
      perfil.must_equal perfil_existente
    end

    it 'carga un perfil con datos cambiados' do
      perfil = constructor_actualizador.construir

      perfil.must_be :changed?
      atributos_de_perfil.each do |atributo|
        perfil.send(atributo).must_equal perfil_cambiado.send(atributo), "Falla #{atributo}"
      end
    end

    it 'actualiza el perfil' do
      perfil = constructor_actualizador.construir

      lambda do
        perfil.save.must_equal true
      end.must_change 'Perfil.count', 0

      perfil_existente.reload
      atributos_de_perfil.each do |atributo|
        perfil_existente.send(atributo).must_equal perfil_cambiado.send(atributo), "Falla #{atributo}"
      end
    end

    it 'no actualiza el usuario' do
      perfil = constructor_actualizador.construir

      perfil.usuario_id.wont_equal perfil_cambiado.usuario_id
      perfil.usuario_id.must_equal perfil_existente.usuario_id
    end
  end

  describe '#construir_horizontes' do
    it 'son nuevos si el perfil es nuevo' do
      perfil = constructor_creador.construir

      perfil.horizontes.any?.must_equal true
      perfil.horizontes.each do |horizonte|
        horizonte.wont_be :persisted?
      end
    end

    it 'crea el perfil y sus horizontes' do
      perfil = constructor_creador.construir

      lambda do
        perfil.save.must_equal true
      end.must_change 'Horizonte.count'
    end

    it 'son existentes si estamos actualizando' do
      perfil = constructor_actualizador.construir

      perfil.horizontes.any?.must_equal true
      perfil.horizontes.each do |horizonte|
        horizonte.must_be :persisted?
      end
    end

    it 'carga horizontes con datos actualizados' do
      perfil = constructor_actualizador.construir

      perfil.must_be :changed?
      perfil.horizontes.size.must_equal perfil_existente.horizontes.size
      perfil.horizontes.each do |h|
        atributos_de_horizonte.each do |atributo|
          h.send(atributo).must_equal perfil_cambiado.horizontes.find(h.id).send(atributo), "Falla #{atributo}"
        end
      end
    end

    it 'actualiza los horizontes' do
      perfil = constructor_actualizador.construir

      lambda do
        perfil.save.must_equal true
      end.must_change 'Horizonte.count', 0

      perfil_existente.reload.horizontes.each do |h|
        atributos_de_horizonte.each do |atributo|
          h.send(atributo).must_equal perfil_cambiado.horizontes.find(h.id).send(atributo), "Falla #{atributo}"
        end
      end
    end

    it 'crea los analíticos' do
      perfil = constructor_creador.construir

      lambda do
        perfil.save.must_equal true
      end.must_change 'Analitico.count'
    end

    it 'carga analíticos con datos actualizados' do
      perfil = constructor_actualizador.construir

      perfil.must_be :changed?
      perfil.analiticos.size.must_equal perfil_existente.horizontes.size
      perfil.analiticos.each do |a|
        atributos_de_analitico.each do |atributo|
          a.send(atributo).must_equal perfil_cambiado.analiticos.find(a.id).send(atributo), "Falla #{atributo}"
        end
      end
    end

    it 'actualiza los analíticos' do
      perfil = constructor_actualizador.construir

      lambda do
        perfil.save.must_equal true
      end.must_change 'Analitico.count', 0

      perfil_existente.reload.analiticos.each do |a|
        atributos_de_analitico.each do |atributo|
          a.send(atributo).must_equal perfil_cambiado.analiticos.find(a.id).send(atributo), "Falla #{atributo}"
        end
      end
    end
  end
end
