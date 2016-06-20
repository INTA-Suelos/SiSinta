class AddIndexToBusquedas < ActiveRecord::Migration
  def change
    add_index :busquedas, :usuario_id
  end
end
