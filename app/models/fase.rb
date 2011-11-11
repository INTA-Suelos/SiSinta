class Fase < ActiveRecord::Base
  has_many :calicatas
#, :inverse_of => :fase
end
