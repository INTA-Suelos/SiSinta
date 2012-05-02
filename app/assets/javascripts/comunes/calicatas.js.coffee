jQuery ->

  $('#calicata_fase_attributes_nombre').autocomplete({ source: "/fases/autocompletar/nombre", delay: 100 })
  $('#calicata_grupo_attributes_descripcion').autocomplete({ source: "/grupos/autocompletar/descripcion", delay: 100 })
  $('.munsell').autocomplete({ source: "/colores/autocompletar/hvc", delay: 100 })
  $('.completa').nestedFields()
