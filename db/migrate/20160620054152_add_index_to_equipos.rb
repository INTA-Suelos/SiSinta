class AddIndexToEquipos < ActiveRecord::Migration
  def change
    add_index :equipos, :usuario_id
  end
end
