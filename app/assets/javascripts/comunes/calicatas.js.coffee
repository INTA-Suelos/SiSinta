jQuery ->

  $('#calicata_fase_attributes_nombre').autocomplete({ source: "/fases/autocompletar/nombre", delay: 100 })
  $('#calicata_grupo_attributes_descripcion').autocomplete({ source: "/grupos/autocompletar/descripcion", delay: 100 })
  $('.munsell').autocomplete({ source: "/colores/autocompletar/hvc", delay: 100 })
  $('.completa').nestedFields({
    afterInsert: ->
      $('.munsell').autocomplete({ source: "/colores/autocompletar/hvc", delay: 100 })
  })
  $('#paginacion')
    .live('ajax:beforeSend', (evt, xhr, settings) ->
      $('body').css('cursor', 'wait') )

    .live('ajax:success', (evt, data, status, xhr) ->
      $('#lista').replaceWith(data)
      $('body').css('cursor', 'auto') )

    .live('ajax:error', (evt, xhr, status) ->
      $('body').css('cursor', 'auto') )
