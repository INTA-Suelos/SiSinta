class Proyecto < ActiveRecord::Base
  attr_accessible :cita, :descripcion, :nombre

  has_and_belongs_to_many :perfiles

  validates_uniqueness_of :nombre
  validates_presence_of   :nombre
end
