# encoding: utf-8
require './test/test_helper'

class ConsistenciaTest < ActiveSupport::TestCase

  setup do
    @consistencia = build_stubbed(:consistencia)
  end

  test "accede a sus asociaciones" do
    assert @consistencia.respond_to? :en_seco, "falla en_seco"
    assert @consistencia.respond_to? :en_humedo, "falla en_humedo"
    assert @consistencia.respond_to? :adhesividad, "falla adhesividad"
    assert @consistencia.respond_to? :plasticidad, "falla plasticidad"
    assert_nothing_raised do
      @consistencia.en_seco
      @consistencia.en_humedo
      @consistencia.adhesividad
      @consistencia.plasticidad
    end
    assert @consistencia.respond_to? :horizonte

    # Pruebo sus lookups
    assert ConsistenciaEnSeco.first.respond_to? :consistencias
    assert ConsistenciaEnHumedo.first.respond_to? :consistencias
    assert AdhesividadDeConsistencia.first.respond_to? :consistencias
    assert PlasticidadDeConsistencia.first.respond_to? :consistencias
  end

end
