class AgregarEquiposUsuariosJoinTable < ActiveRecord::Migration
  def change
    create_table "equipos_usuarios", id: false, force: true do |t|
      t.integer "equipo_id"
      t.integer "usuario_id"
    end

    add_index "equipos_usuarios", ["usuario_id", "equipo_id"], :name => "index_equipos_usuarios_on_usuario_id_and_equipo_id"
  end
end
