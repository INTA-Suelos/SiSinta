# encoding: utf-8
class Paisaje < ActiveRecord::Base
  belongs_to :perfil, inverse_of: :paisaje

  validates_presence_of :perfil
  delegate :publico, :usuario, :usuario_id, to: :perfil

  # TODO A un decorator
  def to_s
    "#{tipo} #{forma} #{simbolo}".chomp
  end

  def self.ransackable_attributes(auth_object = nil)
    super(auth_object) - ['created_at', 'updated_at', 'perfil_id', 'id']
  end
end
