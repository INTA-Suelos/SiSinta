jQuery ->

  split = (val) ->
    val.split( /,\s*/ )

  extractLast = (term) ->
    split( term ).pop()

  nombre =
    delay:      100
    autoFocus:  true
    minLenght:  2
    source:     "/fases/autocompletar/nombre"

  descripcion =
    delay:      100
    autoFocus:  true
    minLenght:  2
    source:     "/grupos/autocompletar/descripcion"

  hvc =
    delay:      100
    autoFocus:  true
    minLenght:  2
    source:     "/colores/autocompletar/hvc"

  etiquetas =
    delay:      100
    autoFocus:  true
    minLenght:  2
    source:    (request, response) ->
      request.term = extractLast(request.term)
      url = "/calicatas/autocompletar/etiquetas"
      $.getJSON(url, request, (data, status, xhr) ->
        response(data)
      )
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

  reconocedores =
    delay:      100
    autoFocus:  true
    minLenght:  2
    source:    (request, response) ->
      request.term = extractLast(request.term)
      url = "/calicatas/autocompletar/reconocedores"
      $.getJSON(url, request, (data, status, xhr) ->
        response(data)
      )
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

  $('#calicata_fase_attributes_nombre').autocomplete(nombre)
  $('#calicata_grupo_attributes_descripcion').autocomplete(descripcion)
  $('.munsell').autocomplete(hvc)
  $('#calicata_etiquetas').autocomplete(etiquetas)
  $('#calicata_reconocedores').autocomplete(reconocedores)

  $('.completa').nestedFields({
    afterInsert: ->
      $('.munsell').autocomplete(hvc)
  })
