class AddIndexToFichas < ActiveRecord::Migration
  def change
    add_index :fichas, :identificador, unique: true
  end
end
