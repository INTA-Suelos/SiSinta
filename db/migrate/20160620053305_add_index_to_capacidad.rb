class AddIndexToCapacidad < ActiveRecord::Migration
  def change
    add_index :capacidades, :perfil_id, unique: true
  end
end
