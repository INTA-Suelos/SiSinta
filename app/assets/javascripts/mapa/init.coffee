jQuery ->
  # Si hay un mapa en la página
  if $('#mapa').length
    # Por default mostramos Argentina entera
    zoom = $('#mapa').data('zoom') || 4
    centro = $('#mapa').data('centro') || [-40, -65]

    mapa = L.map('mapa').setView(centro, zoom)

    osm = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 18
      attribution: '&copy; <a href="http://openstreetmap.org/copyright">OpenStreetMap</a> contributors (' +
        '<a href="http://opendatacommons.org/licenses/odbl/">ODbL</a>)'
    })

    g_terreno = L.gridLayer.googleMutant({ type: 'terrain' })
    g_hibrido = L.gridLayer.googleMutant({ type: 'hybrid' })

    # Capa inicial
    mapa.addLayer(g_hibrido)

    # Capa de geoJson
    geojson = L.geoJson().addTo(mapa)

    # Pide y agrega los puntos
    $.getJSON $('#mapa').data('geojson'), (data) ->
      geojson.addData(data, {
        onEachFeature: preparar_punto
      })

    # Control para cambiar de capas
    mapa.addControl(
      new L.Control.Layers({
        'OpenStreetMap': osm
        'Google': g_hibrido
        'Google Terrain': g_terreno
      }, {
        'Perfiles públicos': geojson
      })
    )

    # Al seleccionar un rectángulo con shift + click, enviamos las coordenadas
    # del rectángulo para seleccionar todos los perfiles internos
    mapa.on 'boxzoomend', (e) ->
      # TODO Revisar si _metodo son APIs internas
      caja = e.boxZoomBounds

      seleccion = new L.Rectangle(caja, {
        color: 'red'
        weight: 3
        opacity: 0.5
        smoothFactor: 1
        className: 'mapa_seleccion'
      })

      # Dibuja la selección actual
      $('.mapa_seleccion').remove()
      seleccion.addTo(mapa)

      coordenadas =
        noreste:
          latitud: caja._northEast.lat
          longitud: caja._northEast.lng
        sudoeste:
          latitud: caja._southWest.lat
          longitud: caja._southWest.lng

      # Envia bounds al server y procesar la respuesta
      # FIXME Arreglar flash
      $.post $(this._container).data('seleccion-url'), coordenadas, (res) ->
        $('#avisos').html $('<div />', { id: "flash_#{res.tipo}", text: res.mensaje })
