jQuery ->

  $('.fecha').datepicker()

  $('.menu .plegable').click ->
    $(this).nextAll().toggle('fast')
    return false

  $('.best_in_place').best_in_place()

  $('#paginacion')
    .live('ajax:beforeSend', (evt, xhr, settings) ->
      $('body').css('cursor', 'wait') )

    .live('ajax:success', (evt, data, status, xhr) ->
      $('#lista').replaceWith(data)
      $('body').css('cursor', 'auto') )

    .live('ajax:error', (evt, xhr, status) ->
      $('body').css('cursor', 'auto') )
