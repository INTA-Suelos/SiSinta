jQuery ->

  # Propiedades comunes a todos los autocompletar
  comunes =
    delay:      100
    autoFocus:  true
    minLength:  2

  (nombre       = comunes).source = "/fases/autocompletar/nombre"
  (descripcion  = comunes).source = "/grupos/autocompletar/descripcion"
  (hvc          = comunes).source = "/colores/autocompletar/hvc"

  $('#calicata_fase_attributes_nombre').autocomplete(nombre)
  $('#calicata_grupo_attributes_descripcion').autocomplete(descripcion)
  $('.munsell').autocomplete(hvc)

  $('.completa').nestedFields({
    afterInsert: ->
      $('.munsell').autocomplete(hvc)
  })
