class CapacidadClase < ActiveRecord::Base
  has_many :capacidades, :inverse_of => :capacidad_clase
end
