# Modelo asociativo para los valores (clase y subclase) de Pedregosidad de cada
# Perfil
class Pedregosidad < ActiveRecord::Base
  belongs_to :perfil, inverse_of: :pedregosidad

  belongs_to :clase, inverse_of: :pedregosidades, class_name: 'ClaseDePedregosidad'
  belongs_to :subclase, inverse_of: :pedregosidades, class_name: 'SubclaseDePedregosidad'

  validates :perfil, presence: true

  delegate :publico, :usuario, :usuario_id, to: :perfil

  # TODO A un decorator
  def to_s
    "#{clase.try(:to_str)} #{subclase}"
  end

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id', 'id']
  end
end
