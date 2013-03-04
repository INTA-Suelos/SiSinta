class Proyecto < ActiveRecord::Base
  attr_accessible :cita, :descripcion, :nombre, :perfiles_attributes, :usuario,
                  :usuario_id

  belongs_to :usuario
  has_and_belongs_to_many :perfiles

  accepts_nested_attributes_for :perfiles, allow_destroy: true

  validates_uniqueness_of :nombre
  validates_presence_of   :nombre
end
