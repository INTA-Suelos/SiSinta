# encoding: utf-8
class TipoDeLimite < Lookup
  has_many :limites, inverse_of: :tipo
end
