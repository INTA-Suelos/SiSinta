class Capacidad < ActiveRecord::Base
  belongs_to :calicata, :inverse_of => :capacidad
  belongs_to :capacidad_clase, :inverse_of => :capacidades
  has_and_belongs_to_many :capacidad_subclases

  validates_presence_of :calicata, :capacidad_clase
end
