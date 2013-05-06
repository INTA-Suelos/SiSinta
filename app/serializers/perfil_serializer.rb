# encoding: utf-8
class PerfilSerializer < ActiveModel::Serializer
  attributes  :id, :numero, :profundidad_napa, :cobertura_vegetal,
              :material_original, :modal, :fecha, :vegetacion_o_cultivos,
              :observaciones

  has_many :horizontes
  has_one :capacidad
  has_one :ubicacion
  has_one :paisaje
  has_one :humedad
  has_one :erosion
  has_one :pedregosidad
  has_one :serie
  has_one :grupo
  has_one :fase

  with_options serializer: LookupSerializer do |l|
    l.has_one :sal, key: :sales
    l.has_one :uso_de_la_tierra
    l.has_one :relieve
    l.has_one :permeabilidad
    l.has_one :escurrimiento
    l.has_one :pendiente
    l.has_one :anegamiento
    l.has_one :drenaje
    l.has_one :posicion
  end

  def to_csv(columnas)
    hash = HashWithIndifferentAccess.new(self.serializable_hash)
    hash.sort.select {|i| columnas.include? i.first}.flatten_tree.values
  end
end
