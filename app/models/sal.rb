class Sal < Lookup
  has_many :calicatas, :inverse_of => :sal
end
