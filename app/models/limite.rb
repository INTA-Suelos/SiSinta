class Limite < ActiveRecord::Base
  belongs_to :horizonte, :inverse_of => :limite

  validates_presence_of :horizonte
end
