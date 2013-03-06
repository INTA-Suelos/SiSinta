class ApplicationDecorator < Draper::Decorator
  delegate_all

  def pista(atributo)
    Ayuda.find_by_campo("#{source.class}.#{atributo}").ejemplo
  end

  def ayuda(atributo)
    h.ayuda_para("#{source.class}.#{atributo}")
  end

  # Convierte el recurso en array, de acuerdo al filtro o por default todos los
  # atributos. Acepta otros decoradores y cualquier método al que responda el
  # objeto.
  def to_array(filtro = nil)
    filtro ||= attributes.keys.flatten
    filtro.inject([]) do |arreglo, atributo|
      arreglo << self.send(atributo)
    end
  end
end
