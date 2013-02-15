# encoding: utf-8
module ApplicationHelper

  # Redirije hacia atrás o en caso de no exister, vuelve al inicio
  def volver
    begin
      redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to :root
    end
  end

  # Crea los divs preparados para el tooltip de los formularios, con la
  # descripción del campo.
  #
  # * *Args*    :
  #   - +campo+ -> El campo del que devolver la descripción.
  #   - +html+ -> Hash de opciones para el div. Se usa +clases+ para determinar
  #   la/las clase/s del +div+, que por default es +ayuda+, e +id+ para
  #   determinar el id, que por default es +ayuda_modelo_campo+
  # * *Returns* :
  #   - Un +div+ preparado con la clase 'ayuda'
  #
  def ayuda_para(campo, html = {})
    texto = Ayuda.find_by_campo(campo).try(:ayuda)
    id = html[:id] || "ayuda_#{campo.gsub('.', '_')}"
    clases = html[:clases] || 'ayuda'

    "<div id='#{id}' class='#{clases}'>#{texto}</div>".html_safe if texto
  end

  # Tomo prestado de http://asciicasts.com/episodes/228-sortable-table-columns
  def link_para_ordenar(columna, titulo = nil)
    columna = columna.to_s  # para permitir símbolos
    titulo ||= columna.titleize
    direccion = (columna == metodo_de_ordenamiento && direccion_de_ordenamiento == "asc") ? "desc" : "asc"
    link_to titulo, por: columna, direccion: direccion
  end

  # Variables para acceder desde la vista y armar las tablas de lookup
  def subclases
    @subclases ||= SubclaseDeCapacidad.all
  end

  def clases
    @clases ||= ClaseDeCapacidad.all
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
    @texturas ||= TexturaDeHorizonte.all
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
    @plasticidades_de_consistencia ||= PlasticidadDeConsistencia.all
  end

  def adhesividades_de_consistencia
    @adhesividades_de_consistencia ||= AdhesividadDeConsistencia.all
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

  def lista_de_fichas
    [
      ['Formulario clásico de Etchevere', 'completa']
    ]
  end

  def titulo(extra = nil)
    "SiSINTA#{extra.nil? ? nil : " | #{extra}"}"
  end

end
