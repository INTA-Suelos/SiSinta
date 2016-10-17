# Modelo asociativo para los valores de Consistencia de cada Horizonte en la
# ficha de Perfiles
class Consistencia < ActiveRecord::Base
  belongs_to :horizonte, inverse_of: :consistencia
  belongs_to :en_seco, class_name: 'ConsistenciaEnSeco', inverse_of: :consistencias
  belongs_to :en_humedo, class_name: 'ConsistenciaEnHumedo', inverse_of: :consistencias
  belongs_to :adhesividad, inverse_of: :consistencias
  belongs_to :plasticidad, inverse_of: :consistencias

  validates :horizonte, presence: true

  delegate :publico, :usuario, :usuario_id, to: :horizonte
end
