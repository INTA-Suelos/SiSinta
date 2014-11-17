jQuery ->
  # Empezar mostrando toda Argentina por default
  zoom = $('#mapa').data('zoom') || 4
  map = L.map('mapa').setView([-40, -65], zoom)

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
    puntos = new L.MarkerClusterGroup()
    puntos.addLayer(
      # Agregar capa de geoJson
      L.geoJson().addData(data)
    ).addTo(map)

    # Encuadrar todos los puntos en el mapa
    map.fitBounds puntos.getBounds()
