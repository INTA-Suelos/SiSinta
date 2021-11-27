require './test/test_helper'

class PerfilSerializerTest < ActiveSupport::TestCase
  let(:perfil) { create(:perfil_completo) }
  let(:datos) { subject.serializable_hash }
  subject { PerfilSerializer.new(perfil) }

  it 'serializa todos los lookups normales' do
    # Lookups
    %i{ drenaje escurrimiento relieve posicion pendiente permeabilidad
        anegamiento uso_de_la_tierra }.each do |lookup|
      _(datos[lookup]).must_equal LookupSerializer.new(perfil.send(lookup)).serializable_hash, "Falló #{lookup}"
    end
  end

  it 'serializa la sal en plural' do
    _(datos[:sales]).must_equal LookupSerializer.new(perfil.sal).serializable_hash
  end

  it 'serializa los campos normales' do
    _(datos[:id]).must_equal perfil.id
    _(datos[:fecha]).must_equal perfil.fecha
    _(datos[:numero]).must_equal perfil.numero
    _(datos[:profundidad_napa]).must_equal perfil.profundidad_napa
    _(datos[:cobertura_vegetal]).must_equal perfil.cobertura_vegetal
    _(datos[:material_original]).must_equal perfil.material_original
    _(datos[:vegetacion_o_cultivos]).must_equal perfil.vegetacion_o_cultivos
    _(datos[:observaciones]).must_equal perfil.observaciones
    _(datos[:publico]).must_equal perfil.publico
  end

  it 'no serializa algunos campos' do
    _(datos[:usuario].blank?).must_equal true
    _(datos[:created_at].blank?).must_equal true
    _(datos[:updated_at].blank?).must_equal true
  end

  describe '#modal' do
    it 'devuelve "modal" si el perfil es modal' do
      hash = PerfilSerializer.new(build(:perfil, modal: true)).serializable_hash

      _(hash[:modal]).must_equal 'modal'
    end

    it 'devuelve "no modal" si el perfil no es modal' do
      hash = PerfilSerializer.new(build(:perfil, modal: false)).serializable_hash

      _(hash[:modal]).must_equal 'no modal'
    end
  end
end
