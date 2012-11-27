# encoding: utf-8
class Pedregosidad < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :perfil, inverse_of: :pedregosidad

  belongs_to_active_hash :clase,    inverse_of: :pedregosidades,
                                    class_name: 'ClaseDePedregosidad'
  belongs_to_active_hash :subclase, inverse_of: :pedregosidades,
                                    class_name: 'SubclaseDePedregosidad'

  validates_presence_of :perfil

  def to_s
    "#{clase.try(:to_str)} #{subclase}"
  end

end
