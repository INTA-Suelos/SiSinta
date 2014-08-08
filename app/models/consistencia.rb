# encoding: utf-8
class Consistencia < ActiveRecord::Base
  belongs_to :horizonte, inverse_of: :consistencia
  has_lookup :en_seco, class_name: 'ConsistenciaEnSeco',
              inverse_of: :consistencias
  has_lookup :en_humedo, class_name: 'ConsistenciaEnHumedo',
              inverse_of: :consistencias
  has_lookup :adhesividad, class_name: 'AdhesividadDeConsistencia',
              inverse_of: :consistencias
  has_lookup :plasticidad, class_name: 'PlasticidadDeConsistencia',
              inverse_of: :consistencias

  validates_presence_of :horizonte
  delegate :publico, :usuario, :usuario_id, to: :horizonte
end
