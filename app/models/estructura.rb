class Estructura < ActiveRecord::Base
  belongs_to :horizonte, :inverse_of => :estructura

  validates_presence_of :horizonte
end
