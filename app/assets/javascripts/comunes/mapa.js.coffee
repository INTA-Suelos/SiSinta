jQuery ->
  # Empezar mostrando toda Argentina por default
  zoom = $('#mapa').data('zoom') || 4
  centro = $('#mapa').data('centro') || [-40, -65]

  mapa = L.map('mapa').setView(centro, zoom)

  osm = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 18
    attribution: '&copy; <a href="http://openstreetmap.org/copyright">OpenStreetMap</a> contributors (' +
      '<a href="http://opendatacommons.org/licenses/odbl/">ODbL</a>)'
  })
  g_hibrido = new L.Google('HYBRID')
  g_terreno = new L.Google('TERRAIN')

  # Capa inicial
  mapa.addLayer(g_hibrido)

  # Control para cambiar de capas
  mapa.addControl(new L.Control.Layers({
    'OSM': osm
    'Google': g_hibrido
    'Google Terrain': g_terreno
  }, {}))

  preparar_puntos = (punto, capa) ->
    serie = if punto.properties.serie
      "<a target='_blank' title='Serie' href='#{punto.properties.serie.url}'>#{
        punto.properties.serie.nombre || 'Serie'}</a> - "
    else
      ''

    capa.bindPopup(
      serie + "<a target='_blank' title='Perfil' href='#{punto.properties.url}'>#{
        punto.properties.numero || 'Perfil'}</a>"
    )

  # Pedir los puntos
  $.getJSON $('#mapa').data('geojson'), (data) ->
    puntos = new L.MarkerClusterGroup()
    puntos.addLayer(
      # Agregar capa de geoJson
      L.geoJson(data, {
        onEachFeature: preparar_puntos
      })
    ).addTo(mapa)

    # Encuadrar todos los puntos en el mapa a menos que definamos un centro
    unless $('#mapa').data('centro')
      mapa.fitBounds puntos.getBounds()
