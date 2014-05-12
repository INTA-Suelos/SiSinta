# encoding: utf-8
class Humedad < ActiveRecord::Base
  belongs_to :perfil, inverse_of: :humedad

  has_lookup :clase, inverse_of: :humedades, class_name: 'ClaseDeHumedad'

  # Pseudoasociación HABTM con SubclaseDeCapacidad. Permite modificarla
  # mediante   # +subclase_ids+ o mediante +subclases+
  serialize :subclase_ids, Array
  guardar_como_arreglo :subclase, SubclaseDeHumedad
  attr_accessor :subclases

  validates_presence_of :perfil
  delegate :publico, :usuario, :usuario_id, to: :perfil

  # TODO reingeniería en +guardar_como_arreglo+
  ransacker :subclase, formatter: proc { |v|
      Humedad.where(Humedad.arel_table[:subclase_ids].matches(
        "%#{SubclaseDeHumedad.find_by_valor(v).id}%"
      )).pluck(:id)
    } do |parent|
    parent.table[:id]
  end

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['perfil_id', 'id', 'subclase_ids']
  end
end
