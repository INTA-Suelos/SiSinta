# encoding: utf-8
class SeriesController < AutorizadoController

  before_filter :preparar, only: [:index]
  before_filter :ordenar, only: [:index]
  before_filter :paginar, only: [:index]

  before_filter :asociar_perfiles, only: [:update]

  # La acción +index+ funciona anónimamente
  skip_before_filter :authenticate_usuario!,  only: [:index]
  skip_load_and_authorize_resource            only: [:index]
  skip_authorization_check                    only: [:index]

  def index
    @titulo = "Series de suelos"
    @series = PaginadorDecorator.decorate @series

    respond_to do |format|
      format.html do
        if request.xhr?   # solicitud ajax para la paginación
          render :index,  layout: false,
                          locals: { series: @series.pagina(params[:pagina]) }
        end
      end
      format.json { render json: @series }
    end
  end

  # Extendemos +ApplicationController#autocompletar+ y definimos el modelo sobre
  # el que consultar, controlando el input del usuario.
  def autocompletar
    case params[:atributo]
      when 'nombre'       then super(Serie, :nombre)
      when 'simbolo'      then super(Serie, :simbolo)
      when 'descripcion'  then super(Serie, :descripcion)
    end
  end

  def show
    @serie = @serie.decorate
    @titulo = "Serie #{@serie.nombre_y_simbolo}"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @serie }
    end
  end

  def new
    @busqueda_perfil = Perfil.search
    @titulo = 'Nueva serie'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @serie }
    end
  end

  def edit
    @busqueda_perfil = Perfil.search
    @serie = @serie.decorate
    @titulo = "Editando serie #{@serie.nombre_y_simbolo}"
  end

  def create
    respond_to do |format|
      if @serie.save
        format.html { buscar_perfiles_o_guardar }
        format.json { render json: @serie, status: :created, location: @serie }
      else
        format.html { render action: "new" }
        format.json { render json: @serie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @serie.update_attributes(params[:serie])
        format.html { buscar_perfiles_o_guardar }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @serie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @serie.destroy

    respond_to do |format|
      format.html { redirect_to series_url }
      format.json { head :no_content }
    end
  end

  private

    def asociar_perfiles
      if params[:perfil_ids]
        # Agregamos sólo los ids que no estaban ya
        nuevos = params[:perfil_ids].collect {|id| id.to_i } - @serie.perfil_ids
        @serie.perfiles << Perfil.find(nuevos)
      end
    end

    def buscar_perfiles_o_guardar
      case params[:commit]
      when 'Buscar'
        session[:despues_de_seleccionar] = serie_path(@serie)
        redirect_to seleccionar_perfiles_path(q: params[:q])
      else
        redirect_to @serie, notice: I18n.t("messages.#{params[:action]}d",  model: 'Serie')
      end
    end

    # Prepara el scope para la lista de series
    def preparar
      # Selecciono sólo lo que necesito en el index
      @series ||= Serie.includes(:perfiles)
    end

    # Ordena los resultados según las columnas de la lista. Si son columnas de
    # texto, las normaliza a lowercase.
    def ordenar
      case @metodo = metodo_de_ordenamiento
      when 'nombre', 'simbolo', 'descripcion, cantidad_de_perfiles'
        @metodo = "lower(#{@metodo})"
      else
        # A los date y boolean no se les aplica lower()
      end
      @series = @series.order("#{@metodo} #{direccion_de_ordenamiento}")
    end

    # Agrega la paginación al scope en curso
    def paginar
      @activo = %w[10 20 50].include?(params[:filas]) ? params[:filas] : '20'
      @series = @series.pagina(params[:pagina]).per(params[:filas])
    end

    # Revisa el input del usuario para los métodos de ordenamiento. Ordena según
    # el +nombre+ por default.
    def metodo_de_ordenamiento
      %w[ nombre simbolo descripcion cantidad_de_perfiles
        ].include?(params[:por]) ? params[:por] : 'nombre'
    end

end
