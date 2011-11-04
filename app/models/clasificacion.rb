class Clasificacion < ActiveRecord::Base
  belongs_to :calicata, :inverse_of => :clasificacion

  validates_presence_of :calicata
end
