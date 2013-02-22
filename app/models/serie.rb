# encoding: utf-8
class Serie < ActiveRecord::Base
  attr_accessible :nombre, :descripcion, :simbolo, :perfiles_attributes

  # Permite utilizar roles sobre este modelo
  resourcify role_cname: 'Rol'

  has_many :perfiles

  accepts_nested_attributes_for :perfiles

  validates_uniqueness_of :nombre, :simbolo, allow_blank: true
  validates_presence_of   :nombre
end
