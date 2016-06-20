class AddIndexToHumedades < ActiveRecord::Migration
  def change
    add_index :humedades, :perfil_id, unique: true
  end
end
