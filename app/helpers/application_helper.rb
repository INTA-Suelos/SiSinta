# Helpers genéricos
module ApplicationHelper
  # Crea los divs preparados para el tooltip de los formularios, con la
  # descripción del campo.
  #
  # * *Args*    :
  #   - +texto+ -> El texto que poner en la ayuda.
  #   - +html+ -> Hash de opciones para el div. Se usa +clases+ para determinar
  #   la/las clase/s del +div+, que por default es +ayuda+, e +id+ para
  #   determinar el id, que por default es nil.
  # * *Returns* :
  #   - Un +div+ preparado con la clase 'ayuda'
  def ayuda_para(texto, html = {})
    id = "id='#{html[:id]}'" if html[:id].present?
    clases = html[:clases] || 'ayuda'

    "<div #{id} class='#{clases}'>#{texto}</div>".html_safe if texto
  end

  # Tomo prestado de http://asciicasts.com/episodes/228-sortable-table-columns
  def link_para_ordenar(columna, titulo = nil)
    columna = columna.to_s  # para permitir símbolos
    titulo ||= columna.titleize
    direccion = (columna == metodo_de_ordenamiento && direccion_de_ordenamiento == "asc") ? "desc" : "asc"
    # TODO ver cómo agregar los `request.query_parameters` actuales sin perder el join
    link_to titulo, por: columna, direccion: direccion
  end

  # Variables para acceder desde la vista y armar las tablas de lookup
  def subclases_de_capacidad
    @subclases_de_capacidad ||= SubclaseDeCapacidad.all
  end

  def clases_de_capacidad
    @clases_de_capacidad ||= ClaseDeCapacidad.all
  end

  def drenajes
    @drenajes ||= Drenaje.all
  end

  def relieves
    @relieves ||= Relieve.all
  end

  def anegamientos
    @anegamientos ||= Anegamiento.all
  end

  def posiciones
    @posiciones ||= Posicion.all
  end

  def pendientes
    @pendientes ||= Pendiente.all
  end

  def pedregosidades
    @pedregosidades ||= Pedregosidad.all
  end

  def escurrimientos
    @escurrimientos ||= Escurrimiento.all
  end

  def permeabilidades
    @permeabilidades ||= Permeabilidad.all
  end

  def sales
    @sales ||= Sal.all
  end

  def usos_de_la_tierra
    @usos_de_la_tierra ||= UsoDeLaTierra.all
  end

  def formas_de_limite
    @formas_de_limite ||= FormaDeLimite.all
  end

  def tipos_de_limite
    @tipos_de_limite ||= TipoDeLimite.all
  end

  def texturas
    @texturas ||= Textura.all
  end

  def formatos_de_coordenadas
    @formatos_de_coordenadas ||= FormatoDeCoordenadas.all
  end

  def tipos_de_estructura
    @tipos_de_estructura ||= TipoDeEstructura.all
  end

  def clases_de_estructura
    @clases_de_estructura ||= ClaseDeEstructura.all
  end

  def grados_de_estructura
    @grados_de_estructura ||= GradoDeEstructura.all
  end

  def consistencias_en_seco
    @consistencias_en_seco ||= ConsistenciaEnSeco.all
  end

  def consistencias_en_humedo
    @consistencias_en_humedo ||= ConsistenciaEnHumedo.all
  end

  def plasticidades_de_consistencia
    @plasticidades_de_consistencia ||= Plasticidad.all
  end

  def adhesividades_de_consistencia
    @adhesividades_de_consistencia ||= Adhesividad.all
  end

  def clases_de_humedad
    @clases_de_humedad ||= ClaseDeHumedad.all
  end

  def subclases_de_humedad
    @subclases_de_humedad ||= SubclaseDeHumedad.all
  end

  def clases_de_pedregosidad
    @clases_de_pedregosidad ||= ClaseDePedregosidad.all
  end

  def subclases_de_pedregosidad
    @subclases_de_pedregosidad ||= SubclaseDePedregosidad.all
  end

  def clases_de_erosion
    @clases_de_erosion ||= ClaseDeErosion.all
  end

  def subclases_de_erosion
    @subclases_de_erosion ||= SubclaseDeErosion.all
  end

  # Título de la página para el +<head>+ por defecto, extra se determina en el
  # helper de cada controlador, dependiendo de la acción
  def titulo_de_la_aplicacion(extra = nil)
    extra ||= titulo_de_la_accion

    [extra, t('app')].reject(&:nil?).join(' | ')
  end

  # Por defecto, no se usa nada. Esto va en la cabecera.
  def titulo_de_la_accion
    case params[:controller]
    when 'devise/registrations'

      case params[:action]
      when 'edit'
        'Detalles de la cuenta'
      when 'new'
        'Creación de la cuenta'
      else
        nil
      end

    when 'devise/sessions'

      case params[:action]
      when 'new'
        'Ingresar al sistema'
      else
        nil
      end

    when 'devise/passwords'

      case params[:action]
      when 'edit'
        'Cambiar el password'
      when 'new'
        'Generar un nuevo password'
      else
        nil
      end

    else
      nil
    end
  end

  # FIXME Integrar en el contenido
  # Por defecto, no se usa nada. Esto va en la cabecera, debajo de +titulo+
  def subtitulo
    nil
  end

  # Genera un checkbox construido para modificar la asociación anidada,
  # determinando si hay que anularla o destruirla
  def destruir_o_anular(recursos, asociacion, id, opciones = {})
    opciones.reverse_merge!({
      alias_de_la_asociacion: nil,
      metodo: '_destroy'
    })

    hash = "#{asociacion}[#{recursos}_attributes]"
    hash << "[#{id}][#{opciones[:metodo]}]"

    valor = case opciones[:metodo]
    when '_destroy'
      true
    when 'anular'
      opciones[:alias_de_la_asociacion] || asociacion
    else
      false
    end

    check_box_tag hash, valor, false, class: 'destroy'
  end

  # Construye el tag de notificación de acuerdo al tipo de mensaje, con botón
  # de dismiss
  def notificacion(tipo, mensaje)
    # A veces guardamos otras cosas en el flash
    if mensaje.is_a?(String)
      content_tag :div, class: notificacion_clases(tipo) do
        concat(
          content_tag(:button, class: 'close', data: { dismiss: 'alert'}) do
            content_tag :span, '&times;'.html_safe
          end
        )

        concat mensaje
      end
    end
  end

  # Convertir nuestros tipos de alertas en los de la interfaz de usuario
  def notificacion_clases(tipo)
    tipo_ui =
      case tipo.to_sym
      when :notice, :success
        :success
      when :alert, :error
        :danger
      else
        :info
      end

    "alert alert-#{tipo_ui} alert-dismissible fade show"
  end

  def mail_de_contacto
    Rails.application.secrets.mail_de_contacto
  end
end
