class AddUsuarioToEquipos < ActiveRecord::Migration
  def change
    add_column :equipos, :usuario_id, :integer
  end
end
