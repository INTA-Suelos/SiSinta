class Paisaje < ActiveRecord::Base
  belongs_to :calicata, :inverse_of => :paisaje

  validates_presence_of :calicata
end
