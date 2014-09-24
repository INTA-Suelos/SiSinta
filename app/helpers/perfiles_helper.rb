# encoding: utf-8
module PerfilesHelper
  include PaginacionHelper
  include AnaliticosHelper

  # Para checkear si debería estar marcado o no el checkbox de la subclase
  # correspondiente
  def tildada?(s)
    @perfil.capacidad.try(:subclases).include?(s)
  end

  # Para el +FormHelper+ necesito los objetos instanciados, aunque no tengan
  # asociaciones realizadas, asique acá les asignamos un objeto nuevo si no
  # tenían ya
  def horizonte_preparado
    Horizonte.new(
      profundidad_superior:
        @perfil.horizontes.empty? ? 0 : @perfil.horizontes.last.profundidad_inferior,
    ).decorate.preparar
  end

  def titulo_de_la_accion
    case params[:action]
      when 'index'
        'Perfiles'
      when 'show'
        "Perfil #{@perfil.numero}"
      when 'new'
        'Nuevo perfil'
      when 'edit'
        "Editando perfil #{@perfil.numero}"
      when 'exportar'
        'Exportar perfiles'
      when 'permisos'
        "Permisos para el perfil #{@recurso.numero}"
      when 'seleccionar'
        "Seleccionar perfiles"
      else
        nil
    end
  end

  def subtitulo
    case params[:action]
      when 'seleccionar'
        if nombre = params[:busqueda]
          "Resultados de #{nombre}"
        end
      else
        nil
    end
  end

  def atributos
    @atributos ||= CSVSerializer.new(Perfil.new).encabezado
  end

  def marcados
    @marcados ||= if self.checks_csv_marcados.any?
      self.checks_csv_marcados
    else
      %w{ id numero fecha serie ubicacion }
    end
  end

  # Define el método a usar por el formulario de selección de perfiles
  def metodo_de_seleccion
    @metodo_de_seleccion ||= (params[:metodo] || :put)
  end

  # Para que la vista averigue a dónde envía el formulario de selección
  def siguiente_url
    @continuar
  end

  # La ficha o plantilla de carga que seleccionó el usuario en la acción
  # anterior o la que definió en su usuario
  def ficha
    @ficha
  end

  protected

    def checks_csv_marcados
      Array.wrap current_usuario.try(:checks_csv_perfiles)
    end
end
