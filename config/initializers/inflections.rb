# encoding : utf-8
# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Agrego cada concepto como irregular porque es más simple y directo que
# determinar las reglas de inflección para el castellano. Rails necesita
# poder pluralizar y singularizar para trabajar con la base de datos
ActiveSupport::Inflector.inflections do |inflect|
  # Terminan en 'e'
  inflect.irregular 'horizonte', 'horizontes'
  inflect.irregular 'serie', 'series'
  inflect.irregular 'paisaje', 'paisajes'
  inflect.irregular 'fase', 'fases'
  inflect.irregular 'limite', 'limites'
  inflect.irregular 'pendiente', 'pendientes'
  inflect.irregular 'relieve', 'relieves'
  inflect.irregular 'drenaje', 'drenajes'
  inflect.irregular 'clase', 'clases'

  # Adjetivadas
  inflect.irregular 'color_seco', 'colores_secos'
  inflect.irregular 'color_humedo', 'colores_humedos'

  # Sustantivo + preposición + sustantivo
  inflect.plural(/^(.*)(_del?_.*)$/i, '\1s\2')
  inflect.plural(/^(.*)([^aeéiou])(_del?_.*)$/i, '\1\2es\3')
  inflect.plural(/^(.*)([aeiou]s)(_del?_.*)$/i, '\1\2\3')
  inflect.plural(/^(.*)z(_del?_.*)$/i, '\1ces\2')
  inflect.plural(/^(.*)á([sn])(_del?_.*)$/i, '\1a\2es\3')
  inflect.plural(/^(.*)é([sn])(_del?_.*)$/i, '\1e\2es\3')
  inflect.plural(/^(.*)í([sn])(_del?_.*)$/i, '\1i\2es\3')
  inflect.plural(/^(.*)ó([sn])(_del?_.*)$/i, '\1o\2es\3')
  inflect.plural(/^(.*)ú([sn])(_del?_.*)$/i, '\1u\2es\3')

  inflect.singular(/^(.*)s(_del?_.*)$/i, '\1\2')
  inflect.singular(/^(.*)es(_del?_.*)$/i, '\1\2')

  inflect.irregular 'consistencia_en_seco', 'consistencias_en_seco'
  inflect.irregular 'consistencia_en_humedo', 'consistencias_en_humedo'
  inflect.irregular 'clase_de_capacidad', 'clases_de_capacidad'
  inflect.irregular 'clase_de_humedad', 'clases_de_humedad'
  inflect.irregular 'clase_de_erosion', 'clases_de_erosion'
  inflect.irregular 'clase_de_pedregosidad', 'clases_de_pedregosidad'
  inflect.irregular 'clase_de_estructura', 'clases_de_estructura'

  # Se mantienen en inglés
  inflect.irregular 'tag', 'tags'
  inflect.irregular 'tagging', 'taggings'
end
