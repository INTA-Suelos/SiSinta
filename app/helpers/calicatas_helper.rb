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

  def horizonte_preparado
    Horizonte.new(
      color_seco: Color.new,
      color_humedo: Color.new,
      limite: Limite.new,
      consistencia: Consistencia.new,
      estructura: Estructura.new
    )
  end

end
