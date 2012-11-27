# encoding: utf-8
class Paisaje < ActiveRecord::Base
  belongs_to :perfil, inverse_of: :paisaje

  validates_presence_of :perfil

  def to_s
    "#{tipo} #{forma} #{simbolo}".chomp
  end

end
