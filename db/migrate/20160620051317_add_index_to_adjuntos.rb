class AddIndexToAdjuntos < ActiveRecord::Migration
  def change
    add_index :adjuntos, :perfil_id
  end
end
