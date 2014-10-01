# encoding: utf-8
class FaseDecorator < ApplicationDecorator
  decorates_association :perfiles, with: PaginadorDecorator

  def to_s
    nombre
  end

  def nombre
    source.try(:nombre) || ''
  end
end
