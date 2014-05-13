# encoding: utf-8
class Erosion < ActiveRecord::Base
  belongs_to :perfil, inverse_of: :erosion

  has_lookup :clase, inverse_of: :erosiones, class_name: 'ClaseDeErosion'
  has_lookup :subclase, inverse_of: :erosiones, class_name: 'SubclaseDeErosion'

  validates_presence_of :perfil
  validate :acumulacion_sin_clase
  delegate :publico, :usuario, :usuario_id, to: :perfil

  # TODO A un decorator
  def to_s
    "#{clase.try(:to_str)} #{subclase}"
  end

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id', 'id']
  end

  private

    # Valida que si se selecciona 'acumulación' no se cargue una clase
    def acumulacion_sin_clase
      if subclase == SubclaseDeErosion.find_by_valor('acumulación') and clase.present?
        errors.add :clase, :debe_estar_en_blanco
      end
    end
end
