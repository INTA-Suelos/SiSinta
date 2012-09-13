# encoding: utf-8
class Sal < Lookup
  has_many :perfiles, inverse_of: :sal
end
