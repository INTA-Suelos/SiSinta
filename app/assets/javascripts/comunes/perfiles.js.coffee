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

  fases =
    source: "/fases/autocompletar/nombre"

  grupos =
    source: "/grupos/autocompletar/descripcion"

  hvc =
    source: "/colores/autocompletar/hvc"

  nombres =
    source: "/series/autocompletar/nombre"

  simbolos =
    source: "/series/autocompletar/simbolo"

  etiquetas = {}

  reconocedores = {}

  # extendemos los objetos con las características comunes
  $.extend fases, comun
  $.extend grupos, comun
  $.extend hvc, comun
  $.extend nombres, comun
  $.extend simbolos, comun
  $.extend etiquetas, comun, autocompletar_varios
  $.extend reconocedores, comun, autocompletar_varios

  $('#perfil_fase_attributes_nombre').autocomplete fases
  $('#perfil_grupo_attributes_descripcion').autocomplete grupos
  $('.munsell').autocomplete hvc
  $('#perfil_etiquetas').autocomplete etiquetas
  $('#perfil_reconocedores').autocomplete reconocedores
  $('#perfil_serie_attributes_nombre').autocomplete nombres
  $('#perfil_serie_attributes_simbolo').autocomplete simbolos

  $('.completa').nestedFields({
    afterInsert: ->
      $('.munsell').autocomplete(hvc)
  })
