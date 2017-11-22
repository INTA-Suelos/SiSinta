# Helpers para cosas relacionadas con la barra de paginación genérica
module PaginacionHelper
  # Control para elegir la cantidad de filas a mostrar
  def elegir_filas(ruta, cantidades = %w{10 20 50})
    @cantidades = cantidades

    content_tag(:div, class: 'elegir_filas') do
      ('Mostrar ' +
      cantidades.collect do |cantidad|
        link_to cantidad, self.send("#{ruta}_path", filas: cantidad), class: activo?(cantidad)
      end.join +
      ' filas').html_safe
    end
  end

  # Devuelve la clase para link de elegir filas dependiendo de si el elemento
  # está activo o no
  def activo?(elemento)
    activo = @cantidades.include?(params[:filas]) ? params[:filas] : '20'

    elemento == activo ? 'activo' : nil
  end
end
