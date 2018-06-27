jQuery ->
  map_container = $('#mapa')

  # If there is a map in this page
  if map_container.length
    # Show the world by default but use configured values if present
    zoom = map_container.data('zoom') || 2
    center = map_container.data('center') || [0, 0]

    mapa = L.map('mapa', {
      center: center
      zoom: zoom
      zoomControl: false
    })

    osm = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 18
      attribution: '&copy; <a href="http://openstreetmap.org/copyright">OpenStreetMap</a> contributors (' +
        '<a href="http://opendatacommons.org/licenses/odbl/">ODbL</a>)'
    })

    g_terreno = L.gridLayer.googleMutant({ type: 'terrain' })
    g_hibrido = L.gridLayer.googleMutant({ type: 'hybrid' })

    # Initial layer
    mapa.addLayer(g_hibrido)

    # Setup GeoJSON layer
    geojson = L.geoJson(null, {
      pointToLayer: Mapa.prepare_marker
      onEachFeature: Mapa.prepare_popup
    }).addTo(mapa)

    # Add zoom control
    L.control.zoom({
      position: 'topright'
    }).addTo(mapa)

    # Add layer control
    L.control.layers({
      'OpenStreetMap': osm
      'Google': g_hibrido
      'Google Terrain': g_terreno
    }, {
      'Perfiles públicos': geojson
    }).addTo(mapa)

    # Add info box
    L.control.info({
      title: map_container.data('infoTitle')
      text: map_container.data('infoText')
    }).addTo(mapa)

    # Al seleccionar un rectángulo con shift + click, enviamos las coordenadas
    # del rectángulo para seleccionar todos los perfiles internos
    # FIXME Extraer a mapa/config
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

    # Retrieve our dataset and add it to the layer
    $.getJSON map_container.data('geojson'), (data) ->
      geojson.addData(data)
