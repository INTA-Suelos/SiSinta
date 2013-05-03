# encoding: utf-8
class Pendiente < Lookup
  has_many :perfiles, inverse_of: :pendiente

  field :valor
end
