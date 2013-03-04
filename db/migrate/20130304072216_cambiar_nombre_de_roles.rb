class CambiarNombreDeRoles < ActiveRecord::Migration
  def up
    Rol.where(name: 'admin', resource_id: nil).update_all(name: 'Administrador')
    Rol.where(name: 'autorizado', resource_id: nil).update_all(name: 'Autorizado')
    Rol.where(name: 'miembro').update_all(name: 'Miembro')
    Rol.where(name: 'invitado').all.map(&:destroy)
  end

  def down
    Rol.where(name: 'Administrador', resource_id: nil).update_all(name: 'admin')
    Rol.where(name: 'Autorizado', resource_id: nil).update_all(name: 'autorizado')
    Rol.where(name: 'Miembro').update_all(name: 'miembro')
    Rol.create(name: 'invitado')
  end
end
