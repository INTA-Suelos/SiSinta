# encoding: utf-8
class Humedad < ActiveRecord::Base
  attr_accessible :clase_id, :subclase_ids

  belongs_to :perfil, inverse_of: :humedad

  has_lookup :clase, inverse_of: :humedades, class_name: 'ClaseDeHumedad'

  # Pseudoasociación HABTM con SubclaseDeCapacidad. Permite modificarla
  # mediante   # +subclase_ids+ o mediante +subclases+
  serialize :subclase_ids, Array
  guardar_como_arreglo :subclase, SubclaseDeHumedad
  attr_accessor :subclases

  validates_presence_of :perfil
  delegate :publico, :usuario, :usuario_id, to: :perfil
end
