jQuery ->

  $('#calicata_fase_attributes_nombre').autocomplete({ source: "/fases/ajax/nombre", delay: 100 })
  $('#calicata_grupo_attributes_descripcion').autocomplete({ source: "/grupos/ajax/descripcion", delay: 100 })
