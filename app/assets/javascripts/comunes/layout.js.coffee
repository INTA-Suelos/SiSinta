# Manejador para remover perfiles asociados con javascript, derivado del de
# awesome_nested_fields
$(document)
  .on 'click', '#perfiles_asociados .borrar a', (evento) ->
    # Anula el click y el movimiendo de pantalla
    evento.preventDefault()
    # El link y el checkbox son hermanos en el mismo td
    $(this).siblings('input.destroy').prop "checked", true
    $(this).parents('tr').hide()

# Invierte el estado de los checkboxes relacionados
$(document)
  .on 'click', '#check_marcar', ->
    estado = not $('#marcar_tag').hasClass('desaparecer')
    $('#marcar_tag, #desmarcar_tag').toggleClass('desaparecer')
    $('.checks input[type=checkbox]').each ->
      $(this).prop 'checked', estado

jQuery ->

  $('.fecha').datepicker()

  $('.menu .plegable + .submenu').toggle()

  $('.menu .plegable').click ->
    $(this).nextAll().toggle('fast')
    return false

  # Oculto el checkbox y muestro el link de awesome_nested_fields, que sólo
  # funciona con js
  $('#perfiles_asociados .borrar a').toggle()
  $('#perfiles_asociados .borrar input').toggle()

  # Empezar mostrando toda Argentina
  map = L.map('mapa').setView([-40, -65], 4)

  # Capa de tiles de MapBox
  # TODO Ver cómo cargar la de geointa o el ign
  L.tileLayer('https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {
    maxZoom: 18
    attribution: 'Map data &copy; ' +
      '<a href="http://openstreetmap.org/copyright">OpenStreetMap</a> contributors (' +
      '<a href="http://opendatacommons.org/licenses/odbl/">ODbL</a>), ' +
      'Imagery &copy; ' +
      '<a href="http://mapbox.com">Mapbox</a>'
    id: 'examples.map-i875mjb7'
  }).addTo(map)

  # Pedir los puntos
  $.getJSON $('#mapa').data('geojson'), (data) ->
    L.geoJson().addTo(map).addData(data)
