class Escurrimiento < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :escurrimiento
end
