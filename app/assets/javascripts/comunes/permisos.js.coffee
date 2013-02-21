$(document)
  .on 'multiselectChange', '#usuarios.multiselect', (evento, ui) ->
    for opcion in ui.optionElements
      $(this).find("option[value='#{opcion.value}']")
        .prop 'selected', ui.selected
    $(this).multiselect 'refresh'

jQuery ->

  $("#usuarios.multiselect").multiselect({
    locale: 'sisinta'
    splitRatio: 0.5
  })
