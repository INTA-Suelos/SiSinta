class TablaJoinUsuariosRoles < ActiveRecord::Migration
  def change
    create_table :roles_usuarios, :id => false do |t|
      t.integer :usuario_id
      t.integer :rol_id
    end
  end
end
