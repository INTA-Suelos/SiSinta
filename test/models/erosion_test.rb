# encoding: utf-8
require './test/test_helper'

class ErosionTest < ActiveSupport::TestCase

  test "carga la clase asociada" do
    atributos = { clase_id: ClaseDeErosion.last.id }

    assert_difference 'ClaseDeErosion.last.erosiones.count' do
      assert create(:erosion).update_attributes(atributos)
    end
  end

  test "no carga erosion sin perfil" do
    assert build_stubbed(:erosion, :sin_perfil).invalid?, "una erosion sin perfil es válida"
  end

  test "accede a sus asociaciones" do
    erosion = build_stubbed(:erosion)
    assert erosion.respond_to? :clase
    assert erosion.respond_to? :subclase
    assert erosion.respond_to? :perfil
    assert_nothing_raised do
      erosion.clase
      erosion.subclase
    end

    # Pruebo sus lookups
    assert ClaseDeErosion.first.respond_to? :erosiones
    assert SubclaseDeErosion.first.respond_to? :erosiones
  end

end
