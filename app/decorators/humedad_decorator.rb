class HumedadDecorator < ApplicationDecorator
  def to_s
    source.subclases.map(&:valor).unshift(
      source.clase.try(:valor)
    ).join(' ').strip
  end
end
