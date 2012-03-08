jQuery ->

  $('#marcar, #desmarcar, #check').click ->
    $('#marcar, #desmarcar').toggleClass('desaparecer')
    if $('#check').attr('checked')
      $('#atributos input[type=checkbox]').each ->
        this.checked = true
    else
      $('#atributos input[type=checkbox]').each ->
        this.checked = false
        true
