class AddPPpmToAnaliticos < ActiveRecord::Migration
  def change
    add_column :analiticos, :p_ppm, :decimal, precision: 4, scale: 1
  end
end
