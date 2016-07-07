class AddArenaTotalToAnaliticos < ActiveRecord::Migration
  def change
    add_column :analiticos, :arena_total, :decimal, precision: 5, scale: 2
  end
end
