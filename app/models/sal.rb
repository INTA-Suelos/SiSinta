# Mantiene los valores posibles para Sales en la ficha de perfiles.
class Sal < ActiveRecord::Base
  has_many :perfiles, inverse_of: :sal

  validates :valor, presence: true
end
