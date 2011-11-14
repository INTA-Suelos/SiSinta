class Permeabilidad < ActiveRecord::Base
  has_many :calicatas, :inverse_of => :permeabilidad
end
