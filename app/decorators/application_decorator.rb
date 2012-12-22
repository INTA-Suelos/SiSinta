class ApplicationDecorator < Draper::Base

  def pista(atributo)
    Ayuda.find_by_campo("#{source.class}.#{atributo}").ejemplo
  end

  def ayuda(atributo)
    h.ayuda_para("#{source.class}.#{atributo}")
  end

end
