# encoding: utf-8
class ClaseDeCapacidad < Lookup
  has_many :capacidades, inverse_of: :clase, foreign_key: 'clase_id'

  def to_str
    codigo
  end

end
