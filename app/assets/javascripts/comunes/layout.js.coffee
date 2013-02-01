jQuery ->

  $('.fecha').datepicker()

  $('.menu .plegable').click ->
    $(this).nextAll().toggle('fast')
    return false

  $('#paginacion')
    .live('ajax:beforeSend', (evt, xhr, settings) ->
      $('body').css('cursor', 'wait') )

    .live('ajax:success', (evt, data, status, xhr) ->
      $('#lista').replaceWith(data)
      $('body').css('cursor', 'auto') )

    .live('ajax:error', (evt, xhr, status) ->
      $('body').css('cursor', 'auto') )

  # Oculto el checkbox y muestro el link de awesome_nested_fields, que sólo
  # funciona con js
  $('#perfiles_asociados .borrar a').toggle()
  $('#perfiles_asociados .borrar input').toggle()
