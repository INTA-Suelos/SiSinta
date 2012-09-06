jQuery ->

  # Propiedades comunes a todos los autocompletar
  comun =
    delay:      100
    autoFocus:  true
    minLength:  2

  etiquetas =
    source: "/calicatas/autocompletar/etiquetas"

  $.extend etiquetas, comun

  $('#q_tags_name_cont').autocomplete etiquetas
