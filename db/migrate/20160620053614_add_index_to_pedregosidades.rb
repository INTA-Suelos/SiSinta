class AddIndexToPedregosidades < ActiveRecord::Migration
  def change
    add_index :pedregosidades, :perfil_id, unique: true
  end
end
