jQuery ->

  # Propiedades comunes a todos los autocompletar
  comunes =
    delay:      100
    autoFocus:  true
    minLength:  2

  (etiquetas  = comunes).source = "/calicatas/autocompletar/etiquetas"

  $('#q_tags_name_cont').autocomplete(etiquetas)
