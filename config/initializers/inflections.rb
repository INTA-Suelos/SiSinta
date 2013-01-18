# -*- encoding : utf-8 -*-
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
  inflect.irregular 'subclase', 'subclases'

  # No contables
  inflect.uncountable 'analisis'

  # Adjetivadas
  inflect.irregular 'color_seco', 'colores_secos'
  inflect.irregular 'color_humedo', 'colores_humedos'

  # Sustantivo + preposición + sustantivo
  inflect.irregular 'textura_de_horizonte', 'texturas_de_horizonte'
  inflect.irregular 'clase_de_capacidad', 'clases_de_capacidad'
  inflect.irregular 'subclase_de_capacidad', 'subclases_de_capacidad'
  inflect.irregular 'uso_de_la_tierra', 'usos_de_la_tierra'
  inflect.irregular 'tipo_de_estructura', 'tipos_de_estructura'
  inflect.irregular 'clase_de_estructura', 'clases_de_estructura'
  inflect.irregular 'grado_de_estructura', 'grados_de_estructura'
  inflect.irregular 'plasticidad_de_consistencia', 'plasticidades_de_consistencia'
  inflect.irregular 'adhesividad_de_consistencia', 'adhesividades_de_consistencia'
  inflect.irregular 'consistencia_en_seco', 'consistencias_en_seco'
  inflect.irregular 'consistencia_en_humedo', 'consistencias_en_humedo'
  inflect.irregular 'tipo_de_limite', 'tipos_de_limite'
  inflect.irregular 'forma_de_limite', 'formas_de_limite'
  inflect.irregular 'formato_de_coordenadas', 'formatos_de_coordenadas'
  inflect.irregular 'subclase_de_pedregosidad', 'subclases_de_pedregosidad'
  inflect.irregular 'clase_de_pedregosidad', 'clases_de_pedregosidad'
  inflect.irregular 'clase_de_humedad', 'clases_de_humedad'
  inflect.irregular 'subclase_de_humedad', 'subclases_de_humedad'
  inflect.irregular 'clase_de_erosion', 'clases_de_erosion'
  inflect.irregular 'subclase_de_erosion', 'subclases_de_erosion'

  # Se mantienen en inglés
  inflect.irregular 'tag', 'tags'
  inflect.irregular 'tagging', 'taggings'
end
