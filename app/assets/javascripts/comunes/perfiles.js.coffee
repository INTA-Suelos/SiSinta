$(document)
  # TODO testear que exista este markup
  .on 'change', '.seleccionar-ficha select', ->
    $(this).siblings('input').click()

jQuery ->

  $('.completa').nestedFields()

  $('select.compacto').select2()
  $('.compacto').css('width', '100%')

  # Ocultar el botón para cambiar plantilla ya que se detecta el evento de
  # selección
  $('.seleccionar-ficha input').toggle()
