# encoding: utf-8
require './test/test_helper'

class HorizonteTest < ActiveSupport::TestCase
  test "crea los colores cuando no existen" do
    assert_difference 'Color.count', 2, "No se crean los colores desde el horizonte" do
      create :horizonte, color_seco_attributes: { hvc: "un color que valide" },
                         color_humedo_attributes: { hvc: "otro color que valide" }
    end
  end

  test "asocia los colores cuando existen previamente" do
    color = create(:color)
    assert_no_difference 'Color.count', "Se crean los colores en vez de asociarse" do
      h = create :horizonte,
        color_seco_attributes: color.serializable_hash.slice("hvc"),
        color_humedo_attributes: color.serializable_hash.slice("hvc")
      assert_equal color, h.color_seco, "El color no se asoció correctamente"
      assert_equal color, h.color_humedo, "El color no se asoció correctamente"
    end
  end
end
