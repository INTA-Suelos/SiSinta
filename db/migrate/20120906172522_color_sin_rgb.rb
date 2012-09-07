class ColorSinRgb < ActiveRecord::Migration
  def up
    change_column :colores, :rgb, :string, null: true

    remove_index "colores", name: "index_colores_on_rgb"
    add_index "colores", ["rgb"], name: "index_colores_on_rgb", unique: false
  end

  def down
    change_column :colores, :rgb, :string, null: false

    remove_index "colores", name: "index_colores_on_rgb"
    add_index "colores", ["rgb"], name: "index_colores_on_rgb", unique: true
  end
end
