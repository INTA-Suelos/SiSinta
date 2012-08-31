# encoding: utf-8
require './test/test_helper'

class ErosionTest < ActiveSupport::TestCase

  fixtures :erosiones

  setup do
    @erosion = erosiones(:uno)
  end

  test "debería cargar la clase asociada" do
    @atributos = { clase_id: ClaseDeErosion.last.id }
    assert_difference 'ClaseDeErosion.last.erosiones.count' do
      @erosion.update_attributes(@atributos)
      assert @erosion.valid?
    end
  end

  test "debería negarse a cargar erosion sin calicata" do
    @atributos = { clase_id: ClaseDeErosion.first.id }
    assert Erosion.new(@atributos).invalid?, "una erosion sin calicata es válida"
  end

  test "debería poder acceder a sus asociaciones" do
    assert @erosion.respond_to? :clase
    assert @erosion.respond_to? :subclase
    assert @erosion.respond_to? :calicata
    assert_nothing_raised do
      @erosion.clase
      @erosion.subclase
    end

    # Pruebo sus lookups
    assert ClaseDeErosion.first.respond_to? :erosiones
    assert SubclaseDeErosion.first.respond_to? :erosiones
  end

end
