# encoding: utf-8
# Clase para procesar archivos CSV y convertirlos a modelos del sistema.
class Deserializador
  attr_accessor :horizontes, :usuario

  # Inicializar un Deserializador para un perfil determinado.
  #
  # horizontes - todos los CSV::Row de un mismo perfil.
  # usuario    - el email del usuario que carga los perfiles (default: nil).
  def initialize(horizontes, usuario = nil)
    @horizontes = horizontes
    @usuario = usuario
  end

  # Agrupa cada fila (un horizonte) del archivo, de acuerdo a la columna 'id',
  # que identifica a todos los horizontes de un mismo perfil.
  #
  # archivo  - un String con el path al archivo `csv`.
  # perfiles - un Hash como el que devuelve este método con perfiles ya
  #            acumulados (default: {}).
  #
  # Devuelve un Hash donde la llave es un id de la columna `id` y el valor es
  # un Array de CSV::Row con los horizontes de ese id.
  def self.parsear_perfiles_de_csv(archivo, perfiles = {})
    CSV.foreach archivo, headers: true do |f|
      id_temporal = f['id']

      perfiles[id_temporal] ||= []
      perfiles[id_temporal] << f
    end
    perfiles
  end

  # Construye un nuevo Perfil y sus asociaciones unitarias en base a los datos
  # de inicialización.
  #
  # Devuelve el Perfil con los datos cargados
  def construir_perfil
    Perfil.new(
      usuario_id: usuario,
      numero: p['perfil_numero'],
      profundidad_napa: p['perfil_profundidad_napa'],
      cobertura_vegetal: p['perfil_cobertura_vegetal'],
      material_original: p['perfil_material_original'],
      modal: p['perfil_modal'],
      fecha: p['perfil_fecha'],
      vegetacion_o_cultivos: p['perfil_vegetacion_o_cultivos'],
      observaciones: p['perfil_observaciones'],
      capacidad_attributes: {
        clase_id: ClaseDeCapacidad.find_by_valor(p['perfil_capacidad_clase']) },
      ubicacion_attributes: {
        descripcion: p['perfil_ubicacion_descripcion'],
        recorrido: p['perfil_ubicacion_recorrido'],
        mosaico: p['perfil_ubicacion_mosaico'],
        aerofoto: p['perfil_ubicacion_aerofoto'],
        coordenadas: p['perfil_ubicacion_coordenadas'] },
      paisaje_attributes: {
        tipo: p['perfil_paisaje_tipo'],
        forma: p['perfil_paisaje_forma'],
        simbolo: p['perfil_paisaje_simbolo'] },
      humedad_attributes: {
        clase_id: ClaseDeHumedad.find_by_valor(p['perfil_humedad_clase']) },
      erosion_attributes: {
        clase_id: ClaseDeErosion.find_by_valor(p['perfil_erosion_clase']),
        subclase_id: SubclaseDeErosion.find_by_valor(p['perfil_erosion_subclase']) },
      pedregosidad_attributes: {
        clase_id: ClaseDePedregosidad.find_by_valor(p['perfil_pedregosidad_clase']),
        subclase_id: SubclaseDePedregosidad.find_by_valor(p['perfil_pedregosidad_subclase']) },
      serie_attributes: {
        nombre: p['perfil_serie_nombre'],
        simbolo: p['perfil_serie_simbolo'],
        provincia_id: Provincia.find_by_valor(p['perfil_serie_provincia']) },
      grupo_attributes: {
        codigo: p['perfil_grupo_codigo'],
        descripcion: p['perfil_grupo_descripcion'] },
      fase_attributes: {
        codigo: p['perfil_fase_codigo'],
        nombre: p['perfil_fase_nombre'] },
      sal_id: Sal.find_by_valor(p['perfil_sales']),
      uso_de_la_tierra_id: UsoDeLaTierra.find_by_valor(p['perfil_uso_de_la_tierra'].try(:downcase)),
      relieve_id: Relieve.find_by_valor(p['perfil_relieve'].try(:downcase)),
      permeabilidad_id: Permeabilidad.find_by_valor(p['perfil_permeabilidad'].try(:downcase)),
      escurrimiento_id: Escurrimiento.find_by_valor(p['perfil_escurrimiento'].try(:downcase)),
      pendiente_id: Pendiente.find_by_valor(p['perfil_pendiente'].try(:downcase)),
      anegamiento_id: Anegamiento.find_by_valor(p['perfil_anegamiento'].try(:downcase)),
      drenaje_id: Drenaje.find_by_valor(p['perfil_drenaje'].try(:downcase)),
      posicion_id: Posicion.find_by_valor(p['perfil_posicion'].try(:downcase))
    )
  end

  # Construye Horizontes y sus asociaciones unitarias a partir de los datos con
  # los que se inicializó el Deserializador, asociándolos a un Perfil
  # determinado por parámetro.
  #
  # perfil - el Perfil al que pertenecen estos horizontes.
  #
  # Devuelve el Perfil con los horizontes cargados
  def construir_horizontes(perfil)
    horizontes.each do |h|
      perfil.horizontes.build(
        profundidad_inferior: h['profundidad_inferior'],
        profundidad_superior: h['profundidad_superior'],
        barnices: h['barnices'],
        co3: h['co3'],
        moteados: h['moteados'],
        ph: h['ph'],
        raices: h['raices'],
        tipo: h['tipo'],
        concreciones: h['concreciones'],
        formaciones_especiales: h['formaciones_especiales'],
        humedad: h['humedad'],
        textura_id: TexturaDeHorizonte.find_by_valor(h['textura']),
        analitico_attributes: {
          registro: h['analitico_registro'],
          humedad: h['analitico_humedad'],
          s: h['analitico_s'],
          h: h['analitico_t'],
          ph_pasta: h['analitico_ph_pasta'],
          ph_h2o: h['analitico_ph_h2o'],
          ph_kcl: h['analitico_ph_kcl'],
          resistencia_pasta: h['analitico_resistencia_pasta'],
          base_ca: h['analitico_base_ca'],
          base_mg: h['analitico_base_mg'],
          base_k: h['analitico_base_k'],
          base_na: h['analitico_base_na'],
          arcilla: h['analitico_arcilla'],
          materia_organica_c: h['analitico_materia_organica_c'],
          materia_organica_n: h['analitico_materia_organica_n'],
          limo_2_20: h['analitico_limo_2_20'],
          limo_2_50: h['analitico_limo_2_50'],
          arena_muy_fina: h['analitico_arena_muy_fina'],
          arena_fina: h['analitico_arena_fina'],
          arena_media: h['analitico_arena_media'],
          arena_gruesa: h['analitico_arena_gruesa'],
          arena_muy_gruesa: h['analitico_arena_muy_gruesa'],
          ca_co3: h['analitico_ca_co3'],
          agua_15_atm: h['analitico_agua_15_atm'],
          agua_util: h['analitico_agua_util'],
          conductividad: h['analitico_conductividad'],
          h: h['analitico_h'],
          saturacion_t: h['analitico_saturacion_t'],
          saturacion_s_h: h['analitico_saturacion_s_h'],
          densidad_aparente: h['analitico_densidad_aparente'],
          profundidad_muestra: h['analitico_profundidad_muestra'],
          agua_3_atm: h['analitico_agua_3_atm'],
          materia_organica_cn: h['analitico_materia_organica_cn'] },
        color_humedo_attributes: {
          hvc: h['color_humedo_hvc'] },
        color_seco_attributes: {
          hvc: h['color_seco_hvc'] },
        consistencia_attributes: {
          en_seco_id: ConsistenciaEnSeco.find_by_valor(h['consistencia_en_seco']),
          en_humedo_id: ConsistenciaEnHumedo.find_by_valor(h['consistencia_en_humedo']),
          adhesividad_id: AdhesividadDeConsistencia.find_by_valor(h['consistencia_adhesividad']),
          plasticidad_id: PlasticidadDeConsistencia.find_by_valor(h['consistencia_plasticidad']) },
        estructura_attributes: {
          tipo_id: TipoDeEstructura.find_by_valor(h['estructura_tipo']),
          clase_id: ClaseDeEstructura.find_by_valor(h['estructura_clase']),
          grado_id: GradoDeEstructura.find_by_valor(h['estructura_grado']) },
        limite_attributes: {
          tipo_id: TipoDeLimite.find_by_valor(h['limite_tipo']),
          forma_id: FormaDeLimite.find_by_valor(h['limite_forma']) }
      )
    end and return perfil
  end

  private

    # Interno: Extrae los datos del perfil de una de las filas. Asume que las
    # columnas con datos del perfil tienen los mismos valores para todos los
    # horizontes (o sea las filas)
    #
    # Devuelve un CSV::Row de donde extraer las columnas para el perfil
    def datos_del_perfil
      horizontes.first
    end
    alias_method :p, :datos_del_perfil
end
