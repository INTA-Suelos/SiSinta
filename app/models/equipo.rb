class Equipo < ActiveRecord::Base
  attr_accessible :nombre, :miembros_attributes

  has_and_belongs_to_many :miembros, class_name: 'Usuario'

  accepts_nested_attributes_for :miembros

  # Permite utilizar roles sobre este modelo
  resourcify role_cname: 'Rol'
end
