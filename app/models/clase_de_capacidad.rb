# encoding: utf-8
class ClaseDeCapacidad < Lookup
  has_many :capacidades, inverse_of: :clase_de_capacidad

  def to_str
    descripcion
  end

end
