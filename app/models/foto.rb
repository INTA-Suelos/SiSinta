class Foto < ActiveRecord::Base
  belongs_to :calicata, :inverse_of => :fotos
end
