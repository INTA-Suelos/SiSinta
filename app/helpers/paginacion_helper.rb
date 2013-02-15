# encoding: utf-8
module PaginacionHelper
  def elegir_filas(ruta, cantidades = %w{10 20 50})
    @cantidades = cantidades

    content_tag(:div, id: 'filas') do
      ('Mostrar ' +
      cantidades.collect do |cantidad|
        link_to cantidad, self.send("#{ruta}_path", filas: cantidad), class: activo?(cantidad)
      end.join +
      ' filas').html_safe
    end
  end

  # Para determinar el elemento activo de la paginación
  def activo?(elemento)
    activo = @cantidades.include?(params[:filas]) ? params[:filas] : '20'
    elemento == activo ? 'activo' : nil
  end
end
