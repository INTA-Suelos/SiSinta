class Serie < ActiveRecord::Base
  attr_accessible :nombre, :descripcion, :simbolo, :perfiles_attributes

  has_many :perfiles

  accepts_nested_attributes_for :perfiles, allow_destroy: true

  validates_uniqueness_of :nombre, :simbolo
  validates_presence_of   :nombre, :simbolo
end
