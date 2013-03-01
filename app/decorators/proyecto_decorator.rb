# encoding: utf-8
class ProyectoDecorator < ApplicationDecorator
  decorates_association :perfiles, with: PaginadorDecorator
end
