# encoding: utf-8
require './test/test_helper'

describe Deserializador::Constructor do
  let(:csv) do
    CSV.parse CSVSerializer.new([build(:perfil)]).as_csv(headers: true), headers: true
  end

  describe '#usuario' do
    let(:usuario) { create(:usuario) }

    it 'acepta un usuario' do
      deserializador = Deserializador::Constructor.new(csv, usuario: usuario).construir

      _(deserializador.usuario).must_equal usuario
    end

    it 'acepta un email' do
      deserializador = Deserializador::Constructor.new(csv, usuario: usuario.email).construir

      _(deserializador.usuario).must_equal usuario
    end

    it 'acepta nil' do
      deserializador = Deserializador::Constructor.new(csv, usuario: nil).construir

      _(deserializador.usuario).must_equal nil
    end

    it 'acepta nada' do
      deserializador = Deserializador::Constructor.new(csv).construir

      _(deserializador.usuario).must_equal nil
    end
  end

  describe '#actualizar?' do
    it 'crea los datos por omisión' do
      Deserializador::Constructor.new(csv).actualizar?.must_equal false
    end

    it 'permite actualizar' do
      Deserializador::Constructor.new(csv, actualizar: true).actualizar?.must_equal true
    end
  end

  describe '#construir_perfil' do
    it 'es nuevo por omisión' do
      Deserializador::Constructor.new(csv).construir_perfil.wont_be :persisted?
    end

    it 'es existente si hay que actualizar' do
      perfil_existente = create(:perfil_completo)
      perfil_instanciado = Deserializador::Constructor.new(
        perfil_a_csv(perfil_existente), actualizar: true
      ).construir_perfil

      perfil_instanciado.must_be :persisted?
      perfil_instanciado.must_equal perfil_existente
    end
  end
end
