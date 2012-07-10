jQuery ->

  $('.plegable legend').click ->
    $(this).nextAll().toggle('slow')
    return false
