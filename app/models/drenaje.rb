# encoding: utf-8
class Drenaje < Lookup
  has_many :perfiles, inverse_of: :drenaje

  field :valor
end
