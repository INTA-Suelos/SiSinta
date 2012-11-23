class Proyecto < ActiveRecord::Base
  attr_accessible :cita, :descripcion, :nombre, :perfil_ids

  has_and_belongs_to_many :perfiles

  accepts_nested_attributes_for :perfiles

  validates_uniqueness_of :nombre
  validates_presence_of   :nombre
end
