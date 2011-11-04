class Color < ActiveRecord::Base
  belongs_to :horizonte, :inverse_of => :color

  validates_presence_of :horizonte
end
