# encoding: utf-8
class FormaDeLimite < Lookup
  has_many :limites, inverse_of: :forma, foreign_key: 'forma_id'
  has_many :horizontes, through: :limites

  field :valor
end
