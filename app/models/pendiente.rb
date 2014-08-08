# encoding: utf-8
class Pendiente < Lookup
  has_many :perfiles

  field :valor
end
