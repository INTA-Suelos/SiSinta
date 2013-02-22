jQuery ->

  comun =
    delay:      100
    autoFocus:  true
    minLenght:  2

  nombres =
    source: "/admin/usuarios/autocompletar/nombre"

  emails =
    source: "/admin/usuarios/autocompletar/email"

  $.extend nombres, comun
  $.extend emails, comun

  $('.nombre input').autocomplete(nombres)
  $('.email input').autocomplete(emails)

  $('#equipo form').nestedFields({
    afterInsert: ->
      $('.nombre input').autocomplete(nombres)
      $('.email input').autocomplete(emails)
  })
