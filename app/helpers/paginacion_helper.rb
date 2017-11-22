# Helpers para cosas relacionadas con la barra de paginación genérica
module PaginacionHelper
  # Control para elegir la cantidad de filas a mostrar
  def elegir_filas(ruta, cantidades = %w{10 20 50})
    cantidades.collect do |cantidad|
      content_tag(:li, class: 'page-item') do
        link_to cantidad,
          self.send("#{ruta}_path", filas: cantidad),
          class: clases_filas(cantidad, cantidades)
      end
    end.join.html_safe
  end

  # Devuelve las clases para los botones de elegir filas, marcando si el
  # elemento está activo o no
  def clases_filas(elemento, cantidades)
    clases = %w{page-link}

    filtro_activo = cantidades.include?(params[:filas]) ? params[:filas] : '20'

    clases.push 'activo' if elemento == filtro_activo

    clases.join ' '
  end
end
