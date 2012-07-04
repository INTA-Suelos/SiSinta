# encoding: utf-8
class UsoDeLaTierra < Lookup
  has_many :calicatas, inverse_of: :uso_de_la_tierra
end
