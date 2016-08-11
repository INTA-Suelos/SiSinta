# Mantiene los valores posibles para Drenaje en la ficha de perfiles.
class Drenaje < ActiveRecord::Base
  has_many :perfiles

  validates :valor, presence: true
end
