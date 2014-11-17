# encoding: utf-8
class PerfilesController < AutorizadoController
  autocomplete :reconocedores, :name, full: true,
    class_name: 'ActsAsTaggableOn::Tag',
    scopes: [ { joins: :taggings }, { where: "taggings.context = 'reconocedores'"} ]
  autocomplete :etiquetas, :name, full: true,
    class_name: 'ActsAsTaggableOn::Tag',
    scopes: [ { joins: :taggings }, { where: "taggings.context = 'etiquetas'"} ]

  has_scope :pagina, default: 1, unless: :geojson?
  has_scope :per, as: :filas, unless: :geojson?
  has_scope :geolocalizados, type: :boolean, default: true, if: :geojson?

  load_and_authorize_resource

  respond_to :geojson, only: [:index, :show]
  respond_to :csv, only: [ :index, :procesar ]

  # acciones que funcionan anónimamente
  skip_before_filter :authenticate_usuario!,  only: [ :index, :seleccionar,
                                                      :derivar, :almacenar,
                                                      :exportar, :show,
                                                      :procesar ]
  skip_load_and_authorize_resource            only: :index
  skip_authorization_check                    only: :index

  with_options only: [:index, :seleccionar, :exportar, :procesar] do |o|
    o.before_filter :preparar
    o.before_filter :ordenar
  end

  before_filter :seleccionar_ficha, only: [:edit, :new, :show]

  before_filter :buscar_perfiles_o_exportar,    only: [:procesar]
  before_filter :cargar_perfiles_seleccionados, only: [:exportar, :procesar]

  def index
    @perfiles = apply_scopes(@perfiles)

    respond_with @perfiles do |format|
      format.html do
        @perfiles = PaginadorDecorator.decorate @perfiles
      end
      format.geojson do
        render json: @perfiles, serializer: GeojsonCollectionSerializer
      end
      format.csv do
        send_data CSVSerializer.new(@perfiles).as_csv(
          headers: true, checks: current_usuario.try(:checks_csv_perfiles)
        ), filename: archivo_csv
      end
    end
  end

  def show
    respond_with @perfil = @perfil.decorate do |format|
      # Serializar como una colección de un sólo miembro
      format.geojson do
        if @perfil.geolocalizado?
          render json: [@perfil], serializer: GeojsonCollectionSerializer
        else
          render json: true, status: :no_content
        end
      end
    end
  end

  def new
    respond_with @perfil = @perfil.decorate
  end

  def edit
    respond_with @perfil = @perfil.decorate
  end

  # Cada usuario es propietario y 'miembro' de los perfiles que crea
  def create
    @perfil.usuario = current_usuario

    # Si falla, responders lo redirige a new
    opciones = if @perfil.save
      current_usuario.grant 'Miembro', @perfil
      { location: perfil_o_analiticos }
    else
      { }
    end

    respond_with (@perfil = @perfil.decorate), opciones
  end

  def update
    # Si falla, responders lo redirige a edit
    opciones = if @perfil.update_attributes(perfil_params)
      { location: perfil_o_analiticos }
    else
      { }
    end

    respond_with (@perfil = @perfil.decorate), opciones
  end

  def destroy
    respond_with @perfil.destroy
  end

  # Preparar los atributos a exportar/importar en CSV
  def exportar
    @busqueda_perfil = Perfil.search(params[:q])
    respond_with @perfiles = PaginadorDecorator.decorate(@perfiles)
  end

  def procesar
    self.perfiles_seleccionados = nil

    respond_with @perfiles, location: nil do |format|
      format.csv do
        send_data CSVSerializer.new(@perfiles).as_csv(
          # FIXME No permite exportar a usuarios anónimos
          headers: true, checks: current_usuario.try(:checks_csv_perfiles),
          base: Perfil
        ), filename: archivo_csv
      end
    end
  end

  def seleccionar
    @continuar = session.delete(:despues_de_seleccionar) || derivar_perfiles_path

    respond_with @perfiles = PaginadorDecorator.decorate(@perfiles)
  end

  def almacenar
    # Perfiles recién seleccionados y los ya viejos
    (self.perfiles_seleccionados += Array.wrap(params[:perfil_ids])).uniq!

    # TODO redirigir según el botón apretado en +seleccionar+ (e.g. puede
    # dirigir a exportar, a eliminar, a rrrear)
    redirect_to exportar_perfiles_path
  end

  def derivar
    # TODO refactorizar en service object
    # Dirije la navegación según el botón que apretó el usuario
    case params[:commit]
    when t('perfiles.seleccionar.volver')
      redirect_to session[:volver_a]
    when t('perfiles.seleccionar.exportar')
      # Usa la acción directamente ya que hace su propia redirección y
      # redirect_to no puede enviar PUTs
      almacenar
    else
      redirect_to perfiles_path # Default amigable
    end
  end

  def editar_analiticos
    respond_with @perfil = @perfil.decorate
  end

  def update_analiticos
    @perfil.update_attributes(perfil_params)
    @perfil = @perfil.decorate
    respond_with @perfil, location: perfil_analiticos_path(@perfil) do |format|
      if @perfil.errors.any?
        format.html { render action: 'editar_analiticos' }
      end
    end
  end

  protected

    def perfil_params
      params.require(:perfil).permit(
        :modal, :fecha, :numero, :vegetacion_o_cultivos, :material_original,
        :drenaje_id, :relieve_id, :anegamiento_id, :posicion_id, :pendiente_id,
        :cobertura_vegetal, :profundidad_napa, :escurrimiento_id, :sal_id,
        :permeabilidad_id, :uso_de_la_tierra_id, :observaciones, :etiqueta_list,
        :reconocedor_list, :publico,
        serie_attributes: %i{ nombre simbolo provincia_id id },
        ubicacion_attributes: %i{
          mosaico recorrido aerofoto id descripcion y x srid },
        fase_attributes: %i{ nombre id },
        grupo_attributes: %i{ descripcion id },
        capacidad_attributes: [ :id, :clase_id, subclase_ids: [] ],
        paisaje_attributes: %i{ tipo forma simbolo id },
        humedad_attributes: [ :id, :clase_id, subclase_ids: [] ],
        pedregosidad_attributes: %i{ clase_id subclase_id id },
        erosion_attributes: %i{ subclase_id clase_id id },
        horizontes_attributes: [
          :tipo, :profundidad_superior, :profundidad_inferior, :textura_id,
          :ph, :co3, :concreciones, :barnices, :moteados, :humedad, :raices,
          :formaciones_especiales, :_destroy, :id,
          limite_attributes: %i{ tipo_id forma_id id },
          color_seco_attributes: %i{ hvc },
          color_humedo_attributes: %i{ hvc },
          estructura_attributes: %i{ tipo_id clase_id grado_id id },
          consistencia_attributes: %i{ en_seco_id en_humedo_id plasticidad_id adhesividad_id id },
        ],
        analiticos_attributes: %i{
          registro profundidad_muestra materia_organica_c materia_organica_n
          materia_organica_cn arcilla limo_2_20 limo_2_50 arena_muy_fina
          arena_fina arena_media arena_gruesa arena_muy_gruesa ca_co3 humedad
          agua_3_atm agua_15_atm agua_util ph_pasta ph_h2o ph_kcl
          resistencia_pasta conductividad base_ca base_mg base_k base_na s h t
          saturacion_t saturacion_s_h densidad_aparente id }
      )
    end

    # Prepara el scope para la lista de perfiles
    def preparar
      # Precargar las asociaciones que necesita el index
      @perfiles ||= Perfil.includes(:ubicacion, :serie)
      @perfiles = @perfiles.search(params[:q]).result.uniq if params[:q].present?
    end

    # Ordena los resultados según las columnas de la lista. Si son columnas de
    # texto, las normaliza a lowercase.
    def ordenar
      # Usar outer join con serie para que no excluya los perfiles sin serie
      @perfiles = @perfiles.joins{ubicacion}.joins{serie.outer}

      case @metodo = metodo_de_ordenamiento
        when 'ubicacion'
          @metodo = 'lower(ubicaciones.descripcion)'
        when 'nombre'
          @metodo = "lower(series.#{@metodo})"
        when 'numero'
          @metodo = "lower(perfiles.#{@metodo})"
        else
          # A los date y boolean no se les aplica lower()
          @metodo = "perfiles.#{@metodo}"
      end
      @perfiles = @perfiles.reorder("#{@metodo} #{direccion_de_ordenamiento}")
    end

    # Determina a dónde redirigir de acuerdo al submit del formulario.
    def perfil_o_analiticos
      case params[:commit]
      when t('helpers.submit.perfil.analiticos')
        editar_analiticos_perfil_path(@perfil)
      when t('helpers.submit.perfil.cambiar_ficha')
        # Un filter carga @ficha con este valor en la siguiente solicitud
        session[:ficha] = Ficha.find_by_valor(params[:ficha]).try(:valor)
        edit_perfil_path(@perfil)
      else
        @perfil
      end
    end

    # Revisa el input del usuario para los métodos de ordenamiento. Ordena según
    # la +fecha+ por default.
    def metodo_de_ordenamiento
      %w[ fecha nombre ubicacion numero modal
        ].include?(params[:por]) ? params[:por] : 'fecha'
    end

    def cargar_perfiles_seleccionados
      @perfiles = @perfiles.where(id: perfiles_seleccionados).uniq
    end

    def buscar_perfiles_o_exportar
      # Guarda los checkboxes que estaban marcados
      if usuario_signed_in?
        current_usuario.update_attribute :checks_csv_perfiles, params[:atributos]
      end

      # TODO extraer a método propio
      # Perfiles con +_destroy+ marcado
      remover = if params[:csv].present?
        params[:csv][:perfiles_attributes].each_pair.collect do |id, atributos|
          id if marcado_para_remover?(atributos)
        end.reject { |elemento| elemento.nil? }
      end
      self.perfiles_seleccionados -= remover unless remover.nil?

      # TODO refactorizar en service object
      # Dirije la navegación según el botón que apretó el usuario
      case params[:commit]
      when t('comunes.perfiles_asociados.submit')
        session[:despues_de_seleccionar] = almacenar_perfiles_path
        redirect_to seleccionar_perfiles_path(q: params[:q])
      when t('perfiles.exportar.submit')
        # Nada, continuamos a procesar
      else
        # Nada, continuamos a procesar
      end
    end

    def perfiles_seleccionados
      Array.wrap session[:perfiles_seleccionados]
    end

    def perfiles_seleccionados=(perfiles)
      session[:perfiles_seleccionados] = perfiles
    end

    def geojson?
      params[:format] == 'geojson'
    end

    def archivo_csv
      "perfiles_#{Date.today.strftime('%Y-%m-%d')}.csv"
    end

    def marcado_para_remover?(hash)
      hash[:_destroy].present? or hash[:anular].present?
    end

    def seleccionar_ficha
      @ficha = session.delete(:ficha) || current_usuario.ficha
    end
end
