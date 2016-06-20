class AddIndexToPerfilesProyectos < ActiveRecord::Migration
  def change
    add_index :perfiles_proyectos, ['proyecto_id', 'perfil_id']
  end
end
