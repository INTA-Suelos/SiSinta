class UbicacionDecorator < ApplicationDecorator
  decorates :ubicacion

  # Transforma del srid real al preferido por el usuario
  def transformar
    @coordenadas ||= Ubicacion.transformar(source.srid, h.current_usuario.srid, source.x, source.y)
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
    begin
      h.current_usuario.srid.to_i
    rescue NoMethodError
      4326
    end
  end

  def redondear(numero)
    numero.try(:round, SiSINTA::Application.config.precision)
  end

  def to_s
    source.descripcion
  end

end
