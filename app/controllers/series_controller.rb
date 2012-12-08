# encoding: utf-8
class SeriesController < AutorizadoController

  # La acción +index+ funciona anónimamente
  skip_before_filter :authenticate_usuario!,  only: [:index]
  skip_load_and_authorize_resource            only: [:index]
  skip_authorization_check                    only: [:index]

  before_filter :asociar_perfiles,            only: [:update]

  # GET /series
  # GET /series.json
  def index
    @titulo = "Series de suelos"
    @series = Serie.all

    respond_to do |format|
      format.html # index.html.{erb,haml}
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

  # GET /series/1
  # GET /series/1.json
  def show
    @serie = @serie.decorate
    @titulo = "Serie #{@serie.nombre} (#{@serie.simbolo})"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @serie }
    end
  end

  # GET /series/new
  # GET /series/new.json
  def new
    @busqueda = Perfil.search
    @titulo = 'Nueva serie'
    @serie = SerieDecorator.decorate(@serie)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @serie }
    end
  end

  # GET /series/1/edit
  def edit
    @busqueda = Perfil.search
    @titulo = "Editando serie #{@serie.nombre}"
    @serie = SerieDecorator.new(@serie)
  end

  # POST /series
  # POST /series.json
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

  # PUT /series/1
  # PUT /series/1.json
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

  # DELETE /series/1
  # DELETE /series/1.json
  def destroy
    @serie.destroy

    respond_to do |format|
      format.html { redirect_to series_url }
      format.json { head :ok }
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
        session[:origen] = serie_path(@serie)
        redirect_to perfiles_path(format: :seleccion, q: params[:q])
      else
        redirect_to @serie, notice: I18n.t("messages.#{params[:action]}d",  model: 'Serie')
      end
    end

end
