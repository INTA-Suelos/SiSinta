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

  # Markup para esconder el texto en tamaños de pantalla menores que md
  def texto_e_icono(key, icono_ultimo: false)
    elementos = [
      t("views.pagination.#{key}.icon"),
      content_tag(:span, t("views.pagination.#{key}.text"), class: 'd-none d-md-inline')
    ]

    # Siguiente y última usan el ícono al final
    elementos.reverse! if icono_ultimo

    elementos.join(' ').html_safe
  end
end
