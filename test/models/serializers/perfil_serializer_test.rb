require './test/test_helper'

class PerfilSerializerTest < ActiveSupport::TestCase
  let(:perfil) { create(:perfil_completo) }
  let(:datos) { subject.serializable_hash }
  subject { PerfilSerializer.new(perfil) }

  it 'serializa todos los lookups normales' do
    # Lookups
    %i{ drenaje escurrimiento relieve posicion pendiente permeabilidad
        anegamiento uso_de_la_tierra }.each do |lookup|
      datos[lookup].must_equal LookupSerializer.new(perfil.send(lookup)).serializable_hash, "Falló #{lookup}"
    end
  end

  it 'serializa la sal en plural' do
    datos[:sales].must_equal LookupSerializer.new(perfil.sal).serializable_hash
  end

  it 'serializa los campos normales' do
    datos[:id].must_equal perfil.id
    datos[:fecha].must_equal perfil.fecha
    datos[:numero].must_equal perfil.numero
    datos[:profundidad_napa].must_equal perfil.profundidad_napa
    datos[:cobertura_vegetal].must_equal perfil.cobertura_vegetal
    datos[:material_original].must_equal perfil.material_original
    datos[:vegetacion_o_cultivos].must_equal perfil.vegetacion_o_cultivos
    datos[:observaciones].must_equal perfil.observaciones
    datos[:publico].must_equal perfil.publico
  end

  it 'no serializa algunos campos' do
    datos[:usuario].blank?.must_equal true
    datos[:created_at].blank?.must_equal true
    datos[:updated_at].blank?.must_equal true
  end

  describe '#modal' do
    it 'devuelve "modal" si el perfil es modal' do
      hash = PerfilSerializer.new(build(:perfil, modal: true)).serializable_hash

      hash[:modal].must_equal 'modal'
    end

    it 'devuelve "no modal" si el perfil no es modal' do
      hash = PerfilSerializer.new(build(:perfil, modal: false)).serializable_hash

      hash[:modal].must_equal 'no modal'
    end
  end
end
