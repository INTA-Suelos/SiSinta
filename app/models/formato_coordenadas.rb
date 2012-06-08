class FormatoCoordenadas < Lookup
  alias_attribute :descripcion, :valor1
  alias_attribute :epsg, :valor2
end
