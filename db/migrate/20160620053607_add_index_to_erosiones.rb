class AddIndexToErosiones < ActiveRecord::Migration
  def change
    add_index :erosiones, :perfil_id, unique: true
  end
end
