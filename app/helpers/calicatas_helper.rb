# -*- encoding : utf-8 -*-
module CalicatasHelper
  def tildada?(s)
    @calicata.capacidad.subclases.include?(s)
  end

  def calicata_preparada
    @calicata.grupo     ||= Grupo.new
    @calicata.paisaje   ||= Paisaje.new
    @calicata.capacidad ||= Capacidad.new
    @calicata.fase      ||= Fase.new
    @calicata.ubicacion ||= Ubicacion.new
    @calicata
  end

end
