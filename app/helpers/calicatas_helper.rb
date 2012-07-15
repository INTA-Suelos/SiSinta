# encoding: utf-8
module CalicatasHelper
  # Para checkear si debería estar marcado o no el checkbox de la subclase
  # correspondiente
  def tildada?(s)
    @calicata.capacidad.try(:subclases).include?(s)
  end

  # Para el +FormHelper+ necesito los objetos instanciados, aunque no tengan
  # asociaciones realizadas, asique acá les asignamos un objeto nuevo si no
  # tenían ya
  def calicata_preparada
    @calicata.grupo     ||= Grupo.new
    @calicata.paisaje   ||= Paisaje.new
    @calicata.capacidad ||= Capacidad.new
    @calicata.fase      ||= Fase.new
    @calicata.ubicacion ||= Ubicacion.new
    @calicata.horizontes.each do |h|
      h.color_seco    || h.build_color_seco
      h.color_humedo  || h.build_color_humedo
      h.limite        || h.build_limite
      h.consistencia  || h.build_consistencia
      h.estructura    || h.build_estructura
    end
    @calicata
  end

  # Para el +FormHelper+ necesito los objetos instanciados, aunque no tengan
  # asociaciones realizadas, asique acá les asignamos un objeto nuevo si no
  # tenían ya
  def horizonte_preparado
    Horizonte.new(
      profundidad_superior:
        @calicata.horizontes.empty? ? 0 : @calicata.horizontes.last.profundidad_inferior,
      color_seco: Color.new,
      color_humedo: Color.new,
      limite: Limite.new,
      consistencia: Consistencia.new,
      estructura: Estructura.new
    )
  end

end
