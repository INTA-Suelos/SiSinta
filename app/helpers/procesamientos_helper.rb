module ProcesamientosHelper
  def titulo_de_la_accion
    case params[:action]
    when 'new'
      'Preparando procesamiento de datos'
    else
      nil
    end
  end

  def subtitulo
    case params[:action]
    when 'new'
      "Para #{@perfiles.size} perfiles."
    else
      nil
    end
  end
end
