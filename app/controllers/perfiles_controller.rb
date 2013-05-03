# encoding: utf-8
class PerfilesController < AutorizadoController
  autocomplete :reconocedores, :name, full: true, class_name: 'RocketTag::Tag',
    scopes: [ { joins: :taggings }, { where: "taggings.context = 'reconocedores'"} ]
  autocomplete :etiquetas, :name, full: true, class_name: 'RocketTag::Tag',
    scopes: [ { joins: :taggings }, { where: "taggings.context = 'etiquetas'"} ]

  has_scope :pagina, default: 1
  has_scope :per, as: :filas
  has_scope :geolocalizados, type: :boolean, default: true, if: :geojson?

  load_and_authorize_resource

  respond_to :geojson, only: :index

  # +index+ funciona anónimamente
  skip_before_filter :authenticate_usuario!,  only: :index
  skip_load_and_authorize_resource            only: :index
  skip_authorization_check                    only: :index

  with_options only: [:index, :seleccionar, :exportar, :procesar_csv] do |o|
    o.before_filter :preparar
    o.before_filter :ordenar
  end

  before_filter :buscar_perfiles_o_exportar,    only: [:procesar_csv]
  before_filter :cargar_perfiles_seleccionados, only: [:exportar, :procesar_csv]

  def index
    @perfiles = apply_scopes(@perfiles)

    respond_with @perfiles do |format|
      format.html do
        @perfiles = PaginadorDecorator.decorate @perfiles
      end
      format.geojson do
        render json: @perfiles, serializer: GeojsonCollectionSerializer
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
    @atributos = Perfil.atributos_y_asociaciones :excepto =>
      [ :created_at, :updated_at, :adjuntos, :horizontes, :etiquetas_taggings,
        :reconocedores_taggings ]

    @marcados = if self.checks_csv_marcados.any?
      self.checks_csv_marcados.map(&:to_sym)
    else
      [ :id, :numero, :fecha, :serie ]
    end

    respond_with @perfiles = PaginadorDecorator.decorate(@perfiles)
  end

  def procesar_csv
    self.perfiles_seleccionados = nil
    super(@perfiles.decorate, 'perfiles')
  end

  def seleccionar
    @continuar = session.delete :despues_de_seleccionar

    respond_with @perfiles = PaginadorDecorator.decorate(@perfiles)
  end

  def almacenar
    # Perfiles recién seleccionados y los ya viejos
    (self.perfiles_seleccionados += Array.wrap(params[:perfil_ids])).uniq!

    redirect_to exportar_perfiles_path
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
      # Selecciono sólo lo que necesito en el index
      @perfiles ||= Perfil.includes(:ubicacion, :serie)
        .select('fecha, modal, numero, perfiles.id, serie_id')
      @perfiles = @perfiles.search(params[:q]).result if params[:q].present?
    end

    # Ordena los resultados según las columnas de la lista. Si son columnas de
    # texto, las normaliza a lowercase.
    def ordenar
      case @metodo = metodo_de_ordenamiento
      when 'ubicacion'
        @perfiles =
          @perfiles.joins(:ubicacion)
                    .select('perfiles.*, ubicaciones.descripcion')
        @metodo = 'lower(ubicaciones.descripcion)'
      when 'nombre', 'numero'
        @metodo = "lower(#{@metodo})"
      else
        # A los date y boolean no se les aplica lower()
      end
      @perfiles = @perfiles.order("#{@metodo} #{direccion_de_ordenamiento}")
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
      @perfiles = @perfiles.where(id: perfiles_seleccionados)
    end

    def buscar_perfiles_o_exportar
      # Guarda los checkboxes que estaban marcados
      self.checks_csv_marcados = params[:atributos]

      # Perfiles con +_destroy+ marcado
      remover = if params[:csv].present?
        params[:csv][:perfiles_attributes].each.collect do |p|
          p.first if p.last[:_destroy]
        end.reject { |elemento| elemento.nil? }
      end
      self.perfiles_seleccionados -= remover unless remover.nil?

      # Dirije la navegación según el botón que apretó el usuario
      case params[:commit]
      when t('comunes.perfiles_asociados.submit')
        session[:despues_de_seleccionar] = almacenar_perfiles_path
        redirect_to seleccionar_perfiles_path(q: params[:q])
      when t('perfiles.exportar.submit')
        # Nada, continuamos a procesar_csv
      else
        # Nada, continuamos a procesar_csv
      end
    end

    def perfiles_seleccionados
      Array.wrap session[:perfiles_seleccionados]
    end

    def perfiles_seleccionados=(perfiles)
      session[:perfiles_seleccionados] = perfiles
    end

    def checks_csv_marcados
      Array.wrap current_usuario.checks_csv_perfiles
    end

    def checks_csv_marcados=(checks)
      current_usuario.update_attribute :checks_csv_perfiles, checks
    end

    def geojson?
      params[:format] == 'geojson'
    end
end
