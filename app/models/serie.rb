class Serie < ActiveRecord::Base
  attr_accessible :nombre, :descripcion, :simbolo, :perfiles_attributes

  has_many :perfiles

  accepts_nested_attributes_for :perfiles, allow_destroy: true

  validates_uniqueness_of :nombre, :simbolo, allow_blank: true
  validates_presence_of   :nombre
end
