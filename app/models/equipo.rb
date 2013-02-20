class Equipo < ActiveRecord::Base
  attr_accessible :nombre

  # Permite utilizar roles sobre este modelo
  resourcify role_cname: 'Rol'

  def miembros
    Usuario.miembros self
  end
end
