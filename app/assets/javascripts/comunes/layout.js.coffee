jQuery ->

  $('.fecha').datepicker()

  $('.menu .plegable').click ->
    $(this).nextAll().toggle('fast')
    return false

  $('.best_in_place').best_in_place()
