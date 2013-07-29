# encoding: utf-8
class ColorDecorator < ApplicationDecorator
  def to_s
    source.hvc || ''
  end
end
