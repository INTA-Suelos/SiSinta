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
  inflect.irregular 'textura', 'texturas'
  inflect.irregular 'calicata', 'calicatas'
  inflect.irregular 'serie', 'series'
  inflect.irregular 'paisaje', 'paisajes'
  inflect.irregular 'fase', 'fases'
  inflect.irregular 'rol', 'roles'
  inflect.irregular 'capacidad', 'capacidades'
  inflect.irregular 'capacidad_clase', 'capacidad_clases'
  inflect.irregular 'capacidad_subclase', 'capacidad_subclases'
  inflect.irregular 'escurrimiento', 'escurrimientos'
  inflect.irregular 'pendiente', 'pendientes'
  inflect.irregular 'permeabilidad', 'permeabilidades'
  inflect.irregular 'relieve', 'relieves'
  inflect.irregular 'anegamiento', 'anegamientos'
  inflect.irregular 'posicion', 'posiciones'
  inflect.irregular 'drenaje', 'drenajes'
  inflect.irregular 'ubicacion', 'ubicaciones'
  inflect.irregular 'sal', 'sales'
  inflect.irregular 'uso_tierra', 'usos_tierra'
  inflect.irregular 'ayuda', 'ayudas'
  inflect.irregular 'grupo', 'grupos'
  inflect.irregular 'limite_tipo', 'limite_tipos'
  inflect.irregular 'limite_forma', 'limite_formas'
  inflect.irregular 'adjunto', 'adjuntos'
  inflect.irregular 'color_seco', 'colores_secos'
  inflect.irregular 'color_humedo', 'colores_humedos'
  inflect.irregular 'formato_coordenadas', 'formatos_coordenadas'
  inflect.irregular 'pedregosidad', 'pedregosidades'
end
