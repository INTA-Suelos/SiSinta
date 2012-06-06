jQuery ->

  $('.fecha').datepicker()

  $('.plegable legend').click ->
    $(this).nextAll().toggle('slow')
    return false

  $('.best_in_place').best_in_place()
