class Adjunto < ActiveRecord::Base
  belongs_to :calicata, :inverse_of => :adjuntos
end
