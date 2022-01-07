# Modelo asociativo para los valores (grado, tipo y clase) de Estructura de cada
# Horizonte en la ficha de Perfiles
class Estructura < ApplicationRecord
  belongs_to :horizonte, inverse_of: :estructura
  belongs_to :tipo, inverse_of: :estructuras, class_name: 'TipoDeEstructura'
  belongs_to :clase, inverse_of: :estructuras, class_name: 'ClaseDeEstructura'
  belongs_to :grado, inverse_of: :estructuras, class_name: 'GradoDeEstructura'

  validates :horizonte, presence: true

  # TODO Revisar dónde es necesario y documentar
  delegate :publico, :usuario, :usuario_id, to: :horizonte
end
