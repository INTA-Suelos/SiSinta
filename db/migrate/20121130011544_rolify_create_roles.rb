class RolifyCreateRoles < ActiveRecord::Migration
  def change
    rename_column :roles, :nombre, :name
    add_column :roles, :resource_id,    :integer
    add_column :roles, :resource_type,  :string

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:roles_usuarios, [ :usuario_id, :rol_id ])
  end
end
