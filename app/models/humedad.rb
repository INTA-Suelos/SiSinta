# encoding: utf-8
class Humedad < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  attr_accessible :clase_id, :subclase_ids

  belongs_to :perfil, inverse_of: :humedad

  belongs_to_active_hash :clase,  inverse_of: :humedades,
                                  class_name: 'ClaseDeHumedad'

  # Pseudoasociación HABTM con SubclaseDeCapacidad. Permite modificarla
  # mediante   # +subclase_ids+ o mediante +subclases+
  serialize :subclase_ids, Array
  guardar_como_arreglo :subclase, SubclaseDeHumedad
  attr_accessor :subclases

  validates_presence_of :perfil
  delegate :publico, :usuario, :usuario_id, to: :perfil

  # TODO A un decorator
  def to_s
    cadena = "#{clase_de_humedad.try(:to_str)}"
    subclases.each do |sc|
      cadena << ' ' << sc
    end
    return cadena
  end

end
