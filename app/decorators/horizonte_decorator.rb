# encoding: utf-8
class HorizonteDecorator < ApplicationDecorator
  decorates_association :color_humedo
  decorates_association :color_seco

  def preparar
    source.color_seco   ||= Color.new
    source.color_humedo ||= Color.new
    source.limite       ||= Limite.new
    source.consistencia ||= Consistencia.new
    source.estructura   ||= Estructura.new
    source.analitico    ||= Analitico.new
    self
  end

end
