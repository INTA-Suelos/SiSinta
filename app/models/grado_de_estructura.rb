# encoding: utf-8
class GradoDeEstructura < Lookup
  has_many :estructuras, inverse_of: :grado, foreign_key: 'grado_id'
end
