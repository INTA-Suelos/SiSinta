jQuery ->

  $('#calicata_serie_attributes_nombre').autocomplete({ source: "/series/ajax/nombre", delay: 100 })
  $('#calicata_gran_grupo').autocomplete({ source: "/calicatas/ajax/gran_grupo", delay: 100 })
