# Modelo asociativo (no tiene datos propios) para los valores (clase y
# subclase) de Erosión en la ficha de Perfiles
class Erosion < ApplicationRecord
  belongs_to :perfil, inverse_of: :erosion

  belongs_to :clase, inverse_of: :erosiones, class_name: 'ClaseDeErosion'
  belongs_to :subclase, inverse_of: :erosiones, class_name: 'SubclaseDeErosion'

  validates :perfil, presence: true
  validate :acumulacion_sin_clase

  delegate :publico, :usuario, :usuario_id, to: :perfil

  # TODO A un decorator
  # FIXME Se usa? En ese caso, pasar a join
  def to_s
    "#{clase.try(:to_str)} #{subclase}"
  end

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id', 'id']
  end

  private

    # Si se selecciona 'acumulación' como Subclase no debe haber Clase
    def acumulacion_sin_clase
      if subclase.try(:acumulacion?) && clase.present?
        errors.add :clase, :debe_estar_en_blanco
      end
    end
end
