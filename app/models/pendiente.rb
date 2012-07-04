# encoding: utf-8
class Pendiente < Lookup
  has_many :calicatas, inverse_of: :pendiente
end
