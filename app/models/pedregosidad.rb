# encoding: utf-8
class Pedregosidad < ActiveRecord::Base
  belongs_to :perfil, inverse_of: :pedregosidad

  has_lookup :clase, inverse_of: :pedregosidades,
              class_name: 'ClaseDePedregosidad'
  has_lookup :subclase, inverse_of: :pedregosidades,
              class_name: 'SubclaseDePedregosidad'

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
