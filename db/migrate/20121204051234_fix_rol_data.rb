class FixRolData < ActiveRecord::Migration
  def up
    # Cada usuario que creó un perfil es miembro del mismo
    Perfil.all.each do |p|
      p.usuario.try(:grant, :miembro, p)
    end
  end

  def down
    # Saco los roles
    Rol.where(name: "miembro").each { |r| r.destroy }
  end
end
