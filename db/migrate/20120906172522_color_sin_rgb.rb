class ColorSinRgb < ActiveRecord::Migration
  def up
    change_column :colores, :rgb, :string, null: true
  end

  def down
    change_column :colores, :rgb, null: false
  end
end
