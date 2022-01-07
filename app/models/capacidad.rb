# Modelo asociativo para los valores (clase y subclases) de Capacidad de cada
# Perfil en la ficha de Perfiles
class Capacidad < ApplicationRecord
  belongs_to :perfil, inverse_of: :capacidad
  belongs_to :clase, class_name: 'ClaseDeCapacidad', inverse_of: :capacidades
  has_and_belongs_to_many :subclases, class_name: 'SubclaseDeCapacidad', inverse_of: :capacidades

  validates :perfil, presence: true

  delegate :publico, :usuario, :usuario_id, to: :perfil

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['perfil_id', 'id', 'subclase_ids']
  end
end
