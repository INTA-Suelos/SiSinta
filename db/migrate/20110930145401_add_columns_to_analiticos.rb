class AddColumnsToAnalisis < ActiveRecord::Migration
  def change
    add_column :analisis, :carbono, :decimal, :precision => 4, :scale => 2
    add_column :analisis, :nitrogeno, :decimal, :precision => 4, :scale => 3
    add_column :analisis, :arcilla, :decimal, :precision => 3, :scale => 1
  end
end
