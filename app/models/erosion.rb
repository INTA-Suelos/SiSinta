# encoding: utf-8
class Erosion < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :perfil, inverse_of: :erosion

  belongs_to_active_hash :clase,    inverse_of: :erosiones,
                                    class_name: 'ClaseDeErosion'
  belongs_to_active_hash :subclase, inverse_of: :erosiones,
                                    class_name: 'SubclaseDeErosion'

  validates_presence_of :perfil

  def to_s
    "#{clase.try(:to_str)} #{subclase}"
  end

end
