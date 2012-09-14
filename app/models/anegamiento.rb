# encoding: utf-8
class Anegamiento < Lookup
  has_many :perfiles, inverse_of: :anegamiento
end
