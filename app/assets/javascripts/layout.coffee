# js relacionado con el layout general de la app y no con páginas específicas

$(window)
  # Siempre que se ajuste el tamaño de la ventana ocultar ciertos elementos (e.g.
  # la barra de búsqueda) y mostrar otros (e.g. el título de la app).
  .resize ->
    $('.hide-on-resize').collapse('hide')
    $('.show-on-resize').collapse('show')
