class Pedregosidad < Lookup
  has_many :calicatas, :inverse_of => :pedregosidad
end
