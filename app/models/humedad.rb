# Modelo asociativo para los valores (clase y subclases) de Humedad de cada
# Perfil en la ficha de Perfiles
class Humedad < ActiveRecord::Base
  belongs_to :perfil, inverse_of: :humedad
  belongs_to :clase, inverse_of: :humedades, class_name: 'ClaseDeHumedad'
  has_and_belongs_to_many :subclases, class_name: 'SubclaseDeHumedad', inverse_of: :capacidades

  validates :perfil, presence: true

  delegate :publico, :usuario, :usuario_id, to: :perfil

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['perfil_id', 'id', 'subclase_ids']
  end
end
