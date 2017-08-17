# encoding: utf-8
module PerfilesHelper
  include PaginacionHelper
  include AnaliticosHelper

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

  # FIXME Integrar en el contenido
  def subtitulo
    case params[:action]
    when 'seleccionar'
      nombre = params[:busqueda]
      if nombre.present?
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
  # FIXME Es peligroso usar params directamente
  def metodo_de_seleccion
    @metodo_de_seleccion ||= (params[:metodo] || :put)
  end

  # Para que la vista averigue a dónde envía el formulario de selección
  def siguiente_url
    @continuar
  end

  protected

    def checks_csv_marcados
      Array.wrap current_usuario.try(:checks_csv_perfiles)
    end
end
