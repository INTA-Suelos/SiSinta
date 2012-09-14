# encoding: utf-8
class Humedad < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :perfil, inverse_of: :humedad

  belongs_to_active_hash :clase,    inverse_of: :humedades,
                                    class_name: 'ClaseDeHumedad'
  belongs_to_active_hash :subclase, inverse_of: :humedades,
                                    class_name: 'SubclaseDeHumedad'

  validates_presence_of :perfil

  def to_s
    "#{clase.try(:to_str)} #{subclase}"
  end

end
