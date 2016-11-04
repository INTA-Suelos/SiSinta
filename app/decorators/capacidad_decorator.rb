class CapacidadDecorator < ApplicationDecorator
  def to_s
    source.subclases.map(&:codigo).unshift(
      source.clase.try(:valor)
    ).join(' ').strip
  end
end
