jQuery ->

  nombre =
    source:     "/fases/autocompletar/nombre"
    delay:      100
    autoFocus:  true
    minLength:  2

  descripcion =
    source:     "/grupos/autocompletar/descripcion"
    delay:      100
    autoFocus:  true
    minLength:  2

  hvc =
    source:     "/colores/autocompletar/hvc"
    delay:      100
    autoFocus:  true
    minLength:  2

  $('#calicata_fase_attributes_nombre').autocomplete(nombre)
  $('#calicata_grupo_attributes_descripcion').autocomplete(descripcion)
  $('.munsell').autocomplete(hvc)

  $('.completa').nestedFields({
    afterInsert: ->
      $('.munsell').autocomplete(hvc)
  })
