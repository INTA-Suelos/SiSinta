class AddGravasToAnaliticos < ActiveRecord::Migration
  def change
    add_column :analiticos, :gravas, :decimal, precision: 5, scale: 2
  end
end
