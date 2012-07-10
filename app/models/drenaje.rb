# encoding: utf-8
class Drenaje < Lookup
  has_many :calicatas, inverse_of: :drenaje
end
