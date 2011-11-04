class Textura < ActiveRecord::Base
  belongs_to :analisis, :inverse_of => :textura

  validates_presence_of :analisis
end
