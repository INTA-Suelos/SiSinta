class Equipo < ActiveRecord::Base
  attr_accessible :nombre

  has_and_belongs_to_many :usuarios

  # Permite utilizar roles sobre este modelo
  resourcify role_cname: 'Rol'
end
