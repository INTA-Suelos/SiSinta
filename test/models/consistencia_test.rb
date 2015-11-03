require './test/test_helper'

describe Consistencia do
  let(:consistencia) { build_stubbed(:consistencia) }

  it 'accede a sus asociaciones' do
    %i{en_seco en_humedo adhesividad plasticidad horizonte}.each do |asociacion|
      consistencia.respond_to?(asociacion).must_equal true, "No responde a #{asociacion}"
    end
  end

  it 'se puede acceder a través de los lookups' do
    [
      ConsistenciaEnSeco,
      ConsistenciaEnHumedo,
      AdhesividadDeConsistencia,
      PlasticidadDeConsistencia
    ].each do |lookup|
      lookup.first.respond_to?(:consistencias).must_equal true, "No se puede acceder a través de #{lookup.name}"
    end
  end
end
