jQuery ->

  $('.fecha').datepicker()

  $('.plegable legend').click ->
    $(this).nextAll().toggle('slow')
    return false
