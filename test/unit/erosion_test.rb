# encoding: utf-8
require './test/test_helper'

class ErosionTest < ActiveSupport::TestCase

  test "debería cargar la clase asociada" do
    atributos = { clase_id: ClaseDeErosion.last.id }

    assert_difference 'ClaseDeErosion.last.erosiones.count' do
      assert create(:erosion).update_attributes(atributos)
    end
  end

  test "debería negarse a cargar erosion sin calicata" do
    assert build_stubbed(:erosion, :sin_calicata).invalid?, "una erosion sin calicata es válida"
  end

  test "debería poder acceder a sus asociaciones" do
    erosion = build_stubbed(:erosion)
    assert erosion.respond_to? :clase
    assert erosion.respond_to? :subclase
    assert erosion.respond_to? :calicata
    assert_nothing_raised do
      erosion.clase
      erosion.subclase
    end

    # Pruebo sus lookups
    assert ClaseDeErosion.first.respond_to? :erosiones
    assert SubclaseDeErosion.first.respond_to? :erosiones
  end

end
