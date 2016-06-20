# El viejo index estaba sobre calicata_id y nunca lo regeneramos
class AddIndexToPaisajeAgain < ActiveRecord::Migration
  def change
    add_index :paisajes, :perfil_id, unique: true
  end
end
