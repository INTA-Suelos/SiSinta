class RenombrarJoinUsuariosRoles < ActiveRecord::Migration
  def change
    # rolify necesita este orden
    rename_table :roles_usuarios, :usuarios_roles
  end
end
