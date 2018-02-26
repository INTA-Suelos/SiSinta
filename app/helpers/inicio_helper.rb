# Métodos de presentación para la landing page
module InicioHelper
  def titulo_de_la_accion
    case params[:action]
    when 'index'
      'Inicio'
    else
      nil
    end
  end
end
