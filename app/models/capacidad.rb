# encoding: utf-8
class Capacidad < ActiveRecord::Base
  attr_accessible :clase_id, :subclase_ids

  belongs_to :perfil, inverse_of: :capacidad

  has_lookup :clase, inverse_of: :capacidades,
              class_name: 'ClaseDeCapacidad'

  # Pseudoasociación HABTM con SubclaseDeCapacidad. Permite modificarla
  # mediante   # +subclase_ids+ o mediante +subclases+
  # TODO ransackerizar subclase_ids
  serialize :subclase_ids, Array
  guardar_como_arreglo :subclase, SubclaseDeCapacidad
  attr_accessor :subclases

  validates_presence_of :perfil
  delegate :publico, :usuario, :usuario_id, to: :perfil

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['perfil_id', 'id']
  end
end
