class ClaseDeCapacidad < Lookup
  has_many :capacidades, inverse_of: :clase_de_capacidad
end
