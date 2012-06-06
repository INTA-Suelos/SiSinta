class Capacidad < ActiveRecord::Base
  belongs_to :calicata, :inverse_of => :capacidad
  belongs_to :capacidad_clase, :inverse_of => :capacidades
  has_and_belongs_to_many :subclases, :class_name => 'CapacidadSubclase'

  accepts_nested_attributes_for :capacidad_clase, :limit => 1
  accepts_nested_attributes_for :subclases

  validates_presence_of :calicata

  def to_str
    cadena = "#{self.capacidad_clase.try(:to_str)}"
    subclases.each do |sc|
      cadena << ' ' << sc.try(:to_str)
    end
    return cadena
  end
end
