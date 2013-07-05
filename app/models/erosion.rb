# encoding: utf-8
class Erosion < ActiveRecord::Base
  attr_accessible :clase_id, :subclase_id

  belongs_to :perfil, inverse_of: :erosion

  has_lookup :clase, inverse_of: :erosiones, class_name: 'ClaseDeErosion'
  has_lookup :subclase, inverse_of: :erosiones, class_name: 'SubclaseDeErosion'

  validates_presence_of :perfil
  delegate :publico, :usuario, :usuario_id, to: :perfil

  # TODO A un decorator
  def to_s
    "#{clase.try(:to_str)} #{subclase}"
  end

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id', 'id']
  end
end
