class Capacidad < ActiveRecord::Base
  belongs_to :calicata, :inverse_of => :capacidad
  belongs_to :clase, :inverse_of => :capacidades, :class_name => 'CapacidadClase'
  has_and_belongs_to_many :subclases, :class_name => 'CapacidadSubclase'

  accepts_nested_attributes_for :clase, :limit => 1
  accepts_nested_attributes_for :subclases

  validates_presence_of :calicata
end
