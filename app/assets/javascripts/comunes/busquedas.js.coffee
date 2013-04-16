$(document)
  .on 'click', 'button.add_fields', ->
    search = new Search({grouping: $('.agrupamiento.template')[0].innerHTML})
    search.add_fields(this, $(this).data('fieldType'), $(this).data('content'))
    return false

$(document)
  .on 'click', 'button.remove_fields', ->
    search = new Search({grouping: $('.agrupamiento.template')[0].innerHTML})
    search.remove_fields(this)
    return false

$(document)
  .on 'click', 'button.nest_fields', ->
    search = new Search({grouping: $('.agrupamiento.template')[0].innerHTML})
    search.nest_fields(this, $(this).data('fieldType'))
    return false
