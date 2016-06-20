class AddIndexToUbicacion < ActiveRecord::Migration
  def change
    add_index :ubicaciones, :perfil_id, unique: true
  end
end
