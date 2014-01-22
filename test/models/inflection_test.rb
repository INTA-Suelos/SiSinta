# encoding: utf-8
require './test/test_helper'

class InflectionTest < ActiveSupport::TestCase

  test "singulariza lo simple" do
    assert_equal 'perfil', 'perfiles'.singularize
    assert_equal 'horizonte', 'horizontes'.singularize
    assert_equal 'analitico', 'analiticos'.singularize
    assert_equal 'usuario', 'usuarios'.singularize
    assert_equal 'color', 'colores'.singularize
    assert_equal 'adjunto', 'adjuntos'.singularize
    assert_equal 'serie', 'series'.singularize
    assert_equal 'paisaje', 'paisajes'.singularize
    assert_equal 'fase', 'fases'.singularize
    assert_equal 'grupo', 'grupos'.singularize
    assert_equal 'rol', 'roles'.singularize
    assert_equal 'proyecto', 'proyectos'.singularize
    assert_equal 'consistencia', 'consistencias'.singularize
    assert_equal 'estructura', 'estructuras'.singularize
    assert_equal 'limite', 'limites'.singularize
    assert_equal 'capacidad', 'capacidades'.singularize
    assert_equal 'escurrimiento', 'escurrimientos'.singularize
    assert_equal 'pendiente', 'pendientes'.singularize
    assert_equal 'permeabilidad', 'permeabilidades'.singularize
    assert_equal 'relieve', 'relieves'.singularize
    assert_equal 'anegamiento', 'anegamientos'.singularize
    assert_equal 'drenaje', 'drenajes'.singularize
    assert_equal 'sal', 'sales'.singularize
    assert_equal 'ayuda', 'ayudas'.singularize
    assert_equal 'pedregosidad', 'pedregosidades'.singularize
    assert_equal 'humedad', 'humedades'.singularize
    assert_equal 'clase', 'clases'.singularize
    assert_equal 'subclase', 'subclases'.singularize
    assert_equal 'tipo', 'tipos'.singularize
    assert_equal 'grado', 'grados'.singularize
    assert_equal 'forma', 'formas'.singularize
    assert_equal 'equipo', 'equipos'.singularize
    assert_equal 'busqueda', 'busquedas'.singularize
  end

  test "singulariza palabras con adjetivo" do
    assert_equal 'color_seco', 'colores_secos'.singularize
    assert_equal 'color_humedo', 'colores_humedos'.singularize
  end

  test "singulariza las relaciones de pertenencia" do
    assert_equal 'textura_de_horizonte', 'texturas_de_horizonte'.singularize
    assert_equal 'clase_de_capacidad', 'clases_de_capacidad'.singularize
    assert_equal 'subclase_de_capacidad', 'subclases_de_capacidad'.singularize
    assert_equal 'uso_de_la_tierra', 'usos_de_la_tierra'.singularize
    assert_equal 'tipo_de_estructura', 'tipos_de_estructura'.singularize
    assert_equal 'clase_de_estructura', 'clases_de_estructura'.singularize
    assert_equal 'grado_de_estructura', 'grados_de_estructura'.singularize
    assert_equal 'plasticidad_de_consistencia', 'plasticidades_de_consistencia'.singularize
    assert_equal 'adhesividad_de_consistencia', 'adhesividades_de_consistencia'.singularize
    assert_equal 'consistencia_en_seco', 'consistencias_en_seco'.singularize
    assert_equal 'consistencia_en_humedo', 'consistencias_en_humedo'.singularize
    assert_equal 'tipo_de_limite', 'tipos_de_limite'.singularize
    assert_equal 'forma_de_limite', 'formas_de_limite'.singularize
    assert_equal 'formato_de_coordenadas', 'formatos_de_coordenadas'.singularize
    assert_equal 'subclase_de_pedregosidad', 'subclases_de_pedregosidad'.singularize
    assert_equal 'clase_de_pedregosidad', 'clases_de_pedregosidad'.singularize
    assert_equal 'clase_de_humedad', 'clases_de_humedad'.singularize
    assert_equal 'subclase_de_humedad', 'subclases_de_humedad'.singularize
    assert_equal 'clase_de_erosion', 'clases_de_erosion'.singularize
    assert_equal 'subclase_de_erosion', 'subclases_de_erosion'.singularize
  end

  test "pluraliza lo simple" do
    assert_equal 'perfiles', 'perfil'.pluralize
    assert_equal 'horizontes', 'horizonte'.pluralize
    assert_equal 'analiticos', 'analitico'.pluralize
    assert_equal 'usuarios', 'usuario'.pluralize
    assert_equal 'colores', 'color'.pluralize
    assert_equal 'adjuntos', 'adjunto'.pluralize
    assert_equal 'series', 'serie'.pluralize
    assert_equal 'paisajes', 'paisaje'.pluralize
    assert_equal 'fases', 'fase'.pluralize
    assert_equal 'grupos', 'grupo'.pluralize
    assert_equal 'roles', 'rol'.pluralize
    assert_equal 'ubicaciones', 'ubicacion'.pluralize
    assert_equal 'proyectos', 'proyecto'.pluralize
    assert_equal 'consistencias', 'consistencia'.pluralize
    assert_equal 'estructuras', 'estructura'.pluralize
    assert_equal 'limites', 'limite'.pluralize
    assert_equal 'capacidades', 'capacidad'.pluralize
    assert_equal 'escurrimientos', 'escurrimiento'.pluralize
    assert_equal 'pendientes', 'pendiente'.pluralize
    assert_equal 'permeabilidades', 'permeabilidad'.pluralize
    assert_equal 'relieves', 'relieve'.pluralize
    assert_equal 'anegamientos', 'anegamiento'.pluralize
    assert_equal 'posiciones', 'posicion'.pluralize
    assert_equal 'drenajes', 'drenaje'.pluralize
    assert_equal 'sales', 'sal'.pluralize
    assert_equal 'ayudas', 'ayuda'.pluralize
    assert_equal 'pedregosidades', 'pedregosidad'.pluralize
    assert_equal 'humedades', 'humedad'.pluralize
    assert_equal 'erosiones', 'erosion'.pluralize
    assert_equal 'clases', 'clase'.pluralize
    assert_equal 'subclases', 'subclase'.pluralize
    assert_equal 'tipos', 'tipo'.pluralize
    assert_equal 'grados', 'grado'.pluralize
    assert_equal 'formas', 'forma'.pluralize
    assert_equal 'equipos', 'equipo'.pluralize
    assert_equal 'busquedas', 'busqueda'.pluralize
  end

  test "pluraliza palabras con adjetivo" do
    assert_equal 'colores_secos', 'color_seco'.pluralize
    assert_equal 'colores_humedos', 'color_humedo'.pluralize
  end

  test "pluraliza las relaciones de pertenencia" do
    assert_equal 'texturas_de_horizonte', 'textura_de_horizonte'.pluralize
    assert_equal 'clases_de_capacidad', 'clase_de_capacidad'.pluralize
    assert_equal 'subclases_de_capacidad', 'subclase_de_capacidad'.pluralize
    assert_equal 'usos_de_la_tierra', 'uso_de_la_tierra'.pluralize
    assert_equal 'tipos_de_estructura', 'tipo_de_estructura'.pluralize
    assert_equal 'clases_de_estructura', 'clase_de_estructura'.pluralize
    assert_equal 'grados_de_estructura', 'grado_de_estructura'.pluralize
    assert_equal 'plasticidades_de_consistencia', 'plasticidad_de_consistencia'.pluralize
    assert_equal 'adhesividades_de_consistencia', 'adhesividad_de_consistencia'.pluralize
    assert_equal 'consistencias_en_seco', 'consistencia_en_seco'.pluralize
    assert_equal 'consistencias_en_humedo', 'consistencia_en_humedo'.pluralize
    assert_equal 'tipos_de_limite', 'tipo_de_limite'.pluralize
    assert_equal 'formas_de_limite', 'forma_de_limite'.pluralize
    assert_equal 'formatos_de_coordenadas', 'formato_de_coordenadas'.pluralize
    assert_equal 'subclases_de_pedregosidad', 'subclase_de_pedregosidad'.pluralize
    assert_equal 'clases_de_pedregosidad', 'clase_de_pedregosidad'.pluralize
    assert_equal 'clases_de_humedad', 'clase_de_humedad'.pluralize
    assert_equal 'subclases_de_humedad', 'subclase_de_humedad'.pluralize
    assert_equal 'clases_de_erosion', 'clase_de_erosion'.pluralize
    assert_equal 'subclases_de_erosion', 'subclase_de_erosion'.pluralize
  end

end
