# encoding: utf-8
require './test/test_helper'

class PerfilSerializerTest < ActiveSupport::TestCase
  setup do
    @perfil = create(:perfil_completo)
    @hash = PerfilSerializer.new(@perfil).serializable_hash
  end

  test 'serializa todos los lookups normales' do
    # Lookups
    %i{ drenaje relieve posicion pendiente escurrimiento permeabilidad
        anegamiento uso_de_la_tierra }.each do |lookup|
      @hash[lookup].must_equal LookupSerializer.new(@perfil.send(lookup)).serializable_hash, "Falló #{lookup}"
    end
  end

  test 'serializa la sal en plural' do
    @hash[:sales].must_equal LookupSerializer.new(@perfil.sal).serializable_hash
  end

  test 'serializa los campos normales' do
    @hash[:id].must_equal @perfil.id
    @hash[:fecha].must_equal @perfil.fecha
    @hash[:numero].must_equal @perfil.numero
    @hash[:modal].must_equal @perfil.modal
    @hash[:profundidad_napa].must_equal @perfil.profundidad_napa
    @hash[:cobertura_vegetal].must_equal @perfil.cobertura_vegetal
    @hash[:material_original].must_equal @perfil.material_original
    @hash[:vegetacion_o_cultivos].must_equal @perfil.vegetacion_o_cultivos
    @hash[:observaciones].must_equal @perfil.observaciones
  end

  test 'no serializa algunos campos' do
    @hash[:usuario].blank?.must_equal true
    @hash[:publico].blank?.must_equal true
    @hash[:created_at].blank?.must_equal true
    @hash[:updated_at].blank?.must_equal true
  end
end
