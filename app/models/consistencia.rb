# encoding: utf-8
class Consistencia < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  attr_accessible :en_seco_id, :en_humedo_id, :plasticidad_id, :adhesividad_id

  belongs_to :horizonte, inverse_of: :consistencia
  belongs_to_active_hash :en_seco, class_name: 'ConsistenciaEnSeco',
                                inverse_of: :consistencias
  belongs_to_active_hash :en_humedo, class_name: 'ConsistenciaEnHumedo',
                                inverse_of: :consistencias
  belongs_to_active_hash :adhesividad, class_name: 'AdhesividadDeConsistencia',
                                inverse_of: :consistencias
  belongs_to_active_hash :plasticidad, class_name: 'PlasticidadDeConsistencia',
                                inverse_of: :consistencias

  validates_presence_of :horizonte
end
