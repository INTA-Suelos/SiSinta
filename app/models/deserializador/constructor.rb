module Deserializador
  class Constructor
    attr_accessor :horizontes, :usuario, :actualizar, :perfil

    # Inicializar un Constructor para un perfil determinado.
    #
    # horizontes - todos los CSV::Row de un mismo perfil.
    # usuario    - el email del usuario que carga los perfiles (default: nil).
    # FIXME aceptar el perfil_id: [horizontes] en vez de sólo [horizontes]
    def initialize(horizontes, opciones = {})
      @horizontes = horizontes
      @actualizar = opciones[:actualizar]
      self.usuario = opciones[:usuario]
    end

    # Construye todos los objetos necesarios en el orden correspondiente
    #
    # Devuelve el Perfil instanciado
    def construir
      construir_horizontes construir_perfil
    end

    # Construye un nuevo Perfil y sus asociaciones unitarias en base a los datos
    # de inicialización.
    #
    # Devuelve el Perfil con los datos cargados
    def construir_perfil
      perfil.assign_attributes(
        usuario_id: usuario.to_param,
        numero: datos['perfil_numero'],
        profundidad_napa: datos['perfil_profundidad_napa'],
        cobertura_vegetal: datos['perfil_cobertura_vegetal'],
        material_original: datos['perfil_material_original'],
        modal: datos['perfil_modal'],
        fecha: datos['perfil_fecha'],
        vegetacion_o_cultivos: datos['perfil_vegetacion_o_cultivos'],
        observaciones: datos['perfil_observaciones'],
        capacidad_attributes: {
          clase_id: ClaseDeCapacidad.where(codigo: datos['perfil_capacidad_clase']).take.to_param },
        ubicacion_attributes: {
          descripcion: datos['perfil_ubicacion_descripcion'],
          recorrido: datos['perfil_ubicacion_recorrido'],
          mosaico: datos['perfil_ubicacion_mosaico'],
          aerofoto: datos['perfil_ubicacion_aerofoto'],
          coordenadas: datos['perfil_ubicacion_coordenadas'] },
        paisaje_attributes: {
          tipo: datos['perfil_paisaje_tipo'],
          forma: datos['perfil_paisaje_forma'],
          simbolo: datos['perfil_paisaje_simbolo'] },
        humedad_attributes: {
          clase_id: ClaseDeHumedad.find_by(valor: datos['perfil_humedad_clase']).to_param },
        erosion_attributes: {
          clase_id: ClaseDeErosion.where(valor: datos['perfil_erosion_clase']).take.to_param,
          subclase_id: SubclaseDeErosion.find_by(valor: datos['perfil_erosion_subclase']).to_param },
        pedregosidad_attributes: {
          clase_id: ClaseDePedregosidad.find_by_valor(datos['perfil_pedregosidad_clase']).to_param,
          subclase_id: SubclaseDePedregosidad.find_by_valor(datos['perfil_pedregosidad_subclase']).to_param },
        serie_attributes: {
          nombre: datos['perfil_serie_nombre'],
          simbolo: datos['perfil_serie_simbolo'],
          provincia_id: Provincia.find_by(nombre: datos['perfil_serie_provincia']).to_param },
        grupo_attributes: {
          codigo: datos['perfil_grupo_codigo'],
          descripcion: datos['perfil_grupo_descripcion'] },
        fase_attributes: {
          codigo: datos['perfil_fase_codigo'],
          nombre: datos['perfil_fase_nombre'] },
        drenaje_id: Drenaje.find_by(valor: datos['perfil_drenaje'].try(:downcase)).to_param,
        escurrimiento_id: Escurrimiento.find_by(valor: datos['perfil_escurrimiento'].try(:downcase)).to_param,
        pendiente_id: Pendiente.find_by(valor: datos['perfil_pendiente'].try(:downcase)).to_param,
        permeabilidad_id: Permeabilidad.find_by(valor: datos['perfil_permeabilidad'].try(:downcase)).to_param,
        relieve_id: Relieve.find_by(valor: datos['perfil_relieve'].try(:downcase)).to_param,
        # FIXME Usar find_by cuando globalize lo agregue a los query methods
        anegamiento_id: Anegamiento.where(valor: datos['perfil_anegamiento'].try(:downcase)).take.to_param,
        uso_de_la_tierra_id: UsoDeLaTierra.find_by(valor: datos['perfil_uso_de_la_tierra'].try(:downcase)).to_param,
        posicion_id: Posicion.find_by(valor: datos['perfil_posicion'].try(:downcase)).to_param,
        sal_id: Sal.find_by(valor: datos['perfil_sales']).to_param
      )

      return perfil
    end

    def perfil
      @perfil ||= actualizar? ? Perfil.find(datos['perfil_id']) : Perfil.new
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

        horizonte = actualizar? ? perfil.horizontes.find(h['id']) : perfil.horizontes.build

        horizonte.assign_attributes(
          profundidad_inferior: h['profundidad_inferior'],
          profundidad_superior: h['profundidad_superior'],
          barnices: h['barnices'],
          co3: h['co3'],
          moteados: h['moteados'],
          ph: h['ph'],
          raices: h['raices'],
          tipo: h['clase'],
          concreciones: h['concreciones'],
          formaciones_especiales: h['formaciones_especiales'],
          humedad: h['humedad'],
          textura_id: Textura.find_by(clase: h['textura']).to_param,
          analitico_attributes: {
            registro: h['analitico_registro'],
            humedad: h['analitico_humedad'],
            s: h['analitico_s'],
            t: h['analitico_t'],
            ph_pasta: h['analitico_ph_pasta'],
            ph_h2o: h['analitico_ph_h2o'],
            ph_kcl: h['analitico_ph_kcl'],
            resistencia_pasta: h['analitico_resistencia_pasta'],
            base_ca: h['analitico_base_ca'],
            base_mg: h['analitico_base_mg'],
            base_k: h['analitico_base_k'],
            base_na: h['analitico_base_na'],
            arcilla: h['analitico_arcilla'],
            carbono_organico_c: h['analitico_carbono_organico_c'],
            carbono_organico_n: h['analitico_carbono_organico_n'],
            carbono_organico_cn: h['analitico_carbono_organico_cn'],
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
            agua_3_atm: h['analitico_agua_3_atm'] },
          color_humedo_attributes: {
            hvc: h['color_humedo_hvc'] },
          color_seco_attributes: {
            hvc: h['color_seco_hvc'] },
          consistencia_attributes: {
            en_seco_id: ConsistenciaEnSeco.find_by(valor: h['consistencia_en_seco']).to_param,
            en_humedo_id: ConsistenciaEnHumedo.find_by(valor: h['consistencia_en_humedo']).to_param,
            # FIXME Usar find_by cuando globalize lo agregue a los query methods
            adhesividad_id: Adhesividad.where(valor: h['consistencia_adhesividad']).take.to_param,
            plasticidad_id: Plasticidad.find_by(valor: h['consistencia_plasticidad']).to_param },
          estructura_attributes: {
            tipo_id: TipoDeEstructura.find_by(valor: h['estructura_tipo']).to_param,
            clase_id: ClaseDeEstructura.find_by(valor: h['estructura_clase']).to_param,
            grado_id: GradoDeEstructura.find_by(valor: h['estructura_grado']).to_param },
          limite_attributes: {
            tipo_id: TipoDeLimite.find_by(valor: h['limite_tipo']).to_param,
            forma_id: FormaDeLimite.find_by(valor: h['limite_forma']).to_param }
        )
      end and return perfil
    end

    # Guarda o instancia al usuario en base al email.
    #
    # Devuelve el Usuario instanciado.
    def usuario=(usuario_o_email)
      @usuario = case usuario_o_email
        when String
          Usuario.find_by(email: usuario_o_email)
        else
          actualizar? ? perfil.usuario : usuario_o_email
        end
    end

    def actualizar?
      actualizar == true
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
    alias_method :datos, :datos_del_perfil
  end
end
