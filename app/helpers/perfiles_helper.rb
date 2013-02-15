# encoding: utf-8
module PerfilesHelper
  include PaginacionHelper

  # Para checkear si debería estar marcado o no el checkbox de la subclase
  # correspondiente
  def tildada?(s)
    @perfil.capacidad.try(:subclases).include?(s)
  end

  # Para el +FormHelper+ necesito los objetos instanciados, aunque no tengan
  # asociaciones realizadas, asique acá les asignamos un objeto nuevo si no
  # tenían ya
  def perfil_preparado
    @perfil.serie         ||= Serie.new
    @perfil.grupo         ||= Grupo.new
    @perfil.paisaje       ||= Paisaje.new
    @perfil.capacidad     ||= Capacidad.new
    @perfil.fase          ||= Fase.new
    @perfil.ubicacion     ||= Ubicacion.new
    @perfil.humedad       ||= Humedad.new
    @perfil.pedregosidad  ||= Pedregosidad.new
    @perfil.erosion       ||= Erosion.new
    @perfil.horizontes.each do |h|
      h.color_seco    || h.build_color_seco
      h.color_humedo  || h.build_color_humedo
      h.limite        || h.build_limite
      h.consistencia  || h.build_consistencia
      h.estructura    || h.build_estructura
    end
    @perfil
  end

  # Para el +FormHelper+ necesito los objetos instanciados, aunque no tengan
  # asociaciones realizadas, asique acá les asignamos un objeto nuevo si no
  # tenían ya
  def horizonte_preparado
    Horizonte.new(
      profundidad_superior:
        @perfil.horizontes.empty? ? 0 : @perfil.horizontes.last.profundidad_inferior,
      color_seco: Color.new,
      color_humedo: Color.new,
      limite: Limite.new,
      consistencia: Consistencia.new,
      estructura: Estructura.new
    )
  end

end
