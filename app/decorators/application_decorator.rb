# encoding: utf-8
class ApplicationDecorator < Draper::Decorator
  delegate_all

  # Convierte el recurso en array, de acuerdo al filtro o por default todos los
  # atributos. Acepta otros decoradores y cualquier método al que responda el
  # objeto.
  # TODO Dónde se usa?
  def to_array(filtro = nil)
    filtro ||= attributes.keys.flatten
    filtro.inject([]) do |arreglo, atributo|
      arreglo << self.send(atributo)
    end
  end
end
