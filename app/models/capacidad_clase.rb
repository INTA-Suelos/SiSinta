class CapacidadClase < ActiveRecord::Base
  has_many :capacidades, :inverse_of => :clase
  has_many :calicatas, :through => :capacidades
end
