class UbicacionDecorator < Draper::Base
  decorates :ubicacion

  # Transforma del srid real al preferido por el usuario
  def transformar
    @coordenadas ||= Ubicacion.transformar(ubicacion.srid, h.current_usuario.srid, ubicacion.x, ubicacion.y)
  end

  # x de acuerdo al SRID preferido
  def x
    redondear transformar.try(:x)
  end

  # y de acuerdo al SRID preferido
  def y
    redondear transformar.try(:y)
  end

  def srid
    h.current_usuario.srid.to_i
  end

  def redondear(numero)
    numero.try(:round, SiSINTA::Application.config.precision)
  end

end
