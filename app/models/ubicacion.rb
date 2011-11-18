class Ubicacion < ActiveRecord::Base
  belongs_to :calicata, :inverse_of => :ubicacion

  validates_presence_of :calicata
end
