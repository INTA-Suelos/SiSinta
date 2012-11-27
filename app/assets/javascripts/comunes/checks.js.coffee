jQuery ->

  $('#check_marcar').change ->
    $('#marcar_tag, #desmarcar_tag').toggleClass('desaparecer')
    if $('#check_marcar').attr('checked')
      $('.checks input[type=checkbox]').each ->
        this.checked = true
    else
      $('.checks input[type=checkbox]').each ->
        this.checked = false
        true
