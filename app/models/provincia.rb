# Una Provincia es una entidad de la primer subdivisión administrativa de un
# Pais. Están relacionadas con datos oficiales de diferentes institutos
# estatales
class Provincia < Lookup
  include ActiveHash::Enum

  # Las series por lo general se ubican geográficamente dentro de provincias
  has_many :series

  field :valor
  field :slug

  enum_accessor :slug

  alias_attribute :nombre, :valor
  # La foreign key de IgnProvincia
  alias_attribute :gid, :ign_provincia_id

  # FIXME Reemplazar por :belongs_to cuando convierta Provincia a ActiveRecord
  def ign_provincia
    IgnProvincia.find_by gid: ign_provincia_id
  end

  # Encuentra las ubicaciones dentro del área de esta provincia
  def ubicaciones
    Ubicacion.en_provincias(self.id)
  end
end
