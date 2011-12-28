class CapacidadSubclase < Lookup
  alias_attribute :codigo, :valor1
  alias_attribute :descripcion, :valor2

  has_and_belongs_to_many :capacidades
  has_many :calicatas, :through => :capacidades
end
