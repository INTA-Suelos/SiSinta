class AddColumnsToAnaliticos < ActiveRecord::Migration
  def change
    add_column :analiticos, :carbono, :decimal, :precision => 4, :scale => 2
    add_column :analiticos, :nitrogeno, :decimal, :precision => 4, :scale => 3
    add_column :analiticos, :arcilla, :decimal, :precision => 3, :scale => 1
  end
end
