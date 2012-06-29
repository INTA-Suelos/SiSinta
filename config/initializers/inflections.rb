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
  inflect.irregular 'horizonte', 'horizontes'
  inflect.irregular 'analisis', 'analisis'
  inflect.irregular 'usuario', 'usuarios'
  inflect.irregular 'color', 'colores'
  inflect.irregular 'consistencia', 'consistencias'
  inflect.irregular 'estructura', 'estructuras'
  inflect.irregular 'limite', 'limites'
  inflect.irregular 'textura_de_horizonte', 'texturas_de_horizonte'
  inflect.irregular 'calicata', 'calicatas'
  inflect.irregular 'serie', 'series'
  inflect.irregular 'paisaje', 'paisajes'
  inflect.irregular 'fase', 'fases'
  inflect.irregular 'rol', 'roles'
  inflect.irregular 'capacidad', 'capacidades'
  inflect.irregular 'clase_de_capacidad', 'clases_de_capacidad'
  inflect.irregular 'subclase_de_capacidad', 'subclases_de_capacidad'
  inflect.irregular 'escurrimiento', 'escurrimientos'
  inflect.irregular 'pendiente', 'pendientes'
  inflect.irregular 'permeabilidad', 'permeabilidades'
  inflect.irregular 'relieve', 'relieves'
  inflect.irregular 'anegamiento', 'anegamientos'
  inflect.irregular 'posicion', 'posiciones'
  inflect.irregular 'drenaje', 'drenajes'
  inflect.irregular 'ubicacion', 'ubicaciones'
  inflect.irregular 'sal', 'sales'
  inflect.irregular 'uso_de_la_tierra', 'usos_de_la_tierra'
  inflect.irregular 'ayuda', 'ayudas'
  inflect.irregular 'grupo', 'grupos'
  inflect.irregular 'tipo_de_limite', 'tipos_de_limite'
  inflect.irregular 'forma_de_limite', 'formas_de_limite'
  inflect.irregular 'adjunto', 'adjuntos'
  inflect.irregular 'color_seco', 'colores_secos'
  inflect.irregular 'color_humedo', 'colores_humedos'
  inflect.irregular 'formato_de_coordenadas', 'formatos_de_coordenadas'
  inflect.irregular 'pedregosidad', 'pedregosidades'
end
