class AddUsuarioToProyecto < ActiveRecord::Migration
  def change
    add_column :proyectos, :usuario_id, :integer
  end
end
