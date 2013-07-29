# encoding: utf-8
class HorizonteDecorator < ApplicationDecorator
  decorates_association :color_humedo
  decorates_association :color_seco

  def to_s
    source.hvc || ''
  end
end
