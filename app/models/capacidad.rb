class Capacidad < ActiveRecord::Base
  belongs_to :calicata, :inverse_of => :capacidad
  belongs_to :clase, :class_name => 'CapacidadClase', :inverse_of => :capacidades
  has_and_belongs_to_many :subclases, :class_name => 'CapacidadSubclase'

  accepts_nested_attributes_for :clase, :limit => 1
  accepts_nested_attributes_for :subclases

  validates_presence_of :calicata

  def to_s
    cadena = "#{self.clase.to_s}"
    subclases.each do |sc|
      cadena << '-' << sc.to_s
    end
    return cadena
  end
end
