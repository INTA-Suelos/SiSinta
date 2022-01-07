# Una Provincia es una entidad de la primer subdivisión administrativa de un
# Pais. Están relacionadas con datos oficiales de diferentes institutos
# estatales
class Provincia < ApplicationRecord
  # Las series por lo general se ubican geográficamente dentro de provincias
  has_many :series

  # El modelo de data_oficial depende del país de la provincia
  belongs_to :data_oficial, polymorphic: true

  validates :nombre, presence: true

  # Encuentra las ubicaciones dentro del área de esta provincia
  def ubicaciones
    Ubicacion.en_provincias(self.id, data_oficial.class)
  end
end
