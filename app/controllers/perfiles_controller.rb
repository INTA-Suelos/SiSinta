# encoding: utf-8
class PerfilesController < AutorizadoController
  autocomplete :reconocedores, :name, full: true, class_name: 'RocketTag::Tag',
    scopes: [ { joins: :taggings }, { where: "taggings.context = 'reconocedores'"} ]
  autocomplete :etiquetas, :name, full: true, class_name: 'RocketTag::Tag',
    scopes: [ { joins: :taggings }, { where: "taggings.context = 'etiquetas'"} ]

  has_scope :pagina, default: 1, unless: :geojson?
  has_scope :per, as: :filas, unless: :geojson?
  has_scope :geolocalizados, type: :boolean, default: true, if: :geojson?

  load_and_authorize_resource

  respond_to :geojson, only: :index
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
    respond_with @perfil = @perfil.decorate
  end

  def new
    respond_with @perfil = @perfil.decorate
  end

  def edit
    respond_with @perfil = @perfil.decorate
  end

  # Cada usuario es propietario y "miembro" de los perfiles que crea
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
    opciones = if @perfil.update_attributes(params[:perfil])
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
    @perfil.update_attributes(params[:perfil])
    @perfil = @perfil.decorate
    respond_with @perfil, location: perfil_analiticos_path(@perfil) do |format|
      if @perfil.errors.any?
        format.html { render action: 'editar_analiticos' }
      end
    end
  end

  protected

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

    # Determina si el usuario terminó de editar el perfil o va a seguir con los
    # datos analíticos
    # TODO Revisar que envíe al edit
    def perfil_o_analiticos
      params[:analiticos].present? ? editar_analiticos_perfil_path(@perfil) : @perfil
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
end
