class CapacidadClase < Lookup
  alias_attribute :codigo, :valor1
  alias_attribute :descripcion, :valor2
  alias_attribute :agrupamiento, :valor3

  has_many :capacidades, :inverse_of => :clase
  has_many :calicatas, :through => :capacidades
end
