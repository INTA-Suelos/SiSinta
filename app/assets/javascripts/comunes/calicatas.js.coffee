jQuery ->

  split = (val) ->
    val.split( /,\s*/ )

  extractLast = (term) ->
    split( term ).pop()

  comun =
    delay:      100
    autoFocus:  true
    minLenght:  2

  autocompletar_varios =
    focus:      ->
      false
    select:     (event, ui) ->
      terms = split( this.value )
      # remove the current input
      terms.pop()
      # add the selected item
      terms.push( ui.item.value )
      # add placeholder to get the comma-and-space at the end
      terms.push( "" )
      this.value = terms.join( ", " )
      false
    source:    (request, response) ->
      request.term = extractLast(request.term)
      # this.element.data se define en las vistas
      $.getJSON(this.element.data('url'), request, (data, status, xhr) ->
        response(data)
      )

  nombre =
    source: "/fases/autocompletar/nombre"

  descripcion =
    source: "/grupos/autocompletar/descripcion"

  hvc =
    source: "/colores/autocompletar/hvc"

  etiquetas = {}

  reconocedores = {}

  # extendemos los objetos con las características comunes
  $.extend nombre, comun
  $.extend descripcion, comun
  $.extend hvc, comun
  $.extend etiquetas, comun, autocompletar_varios
  $.extend reconocedores, comun, autocompletar_varios

  $('#calicata_fase_attributes_nombre').autocomplete nombre
  $('#calicata_grupo_attributes_descripcion').autocomplete descripcion
  $('.munsell').autocomplete hvc
  $('#calicata_etiquetas').autocomplete etiquetas
  $('#calicata_reconocedores').autocomplete reconocedores

  $('.completa').nestedFields({
    afterInsert: ->
      $('.munsell').autocomplete(hvc)
  })
