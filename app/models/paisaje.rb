# encoding: utf-8
class Paisaje < ActiveRecord::Base
  attr_accessible :tipo, :forma, :simbolo, :perfil

  belongs_to :perfil, inverse_of: :paisaje

  validates_presence_of :perfil

  # TODO A un decorator
  def to_s
    "#{tipo} #{forma} #{simbolo}".chomp
  end

end
