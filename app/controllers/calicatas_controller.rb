# encoding: utf-8
class CalicatasController < AutorizadoController

  before_filter :armar_lookups, except: [:index, :preparar_csv]
  before_filter :series_o_calicatas,
                only: [:index, :geo, :preparar_csv, :procesar_csv]
  before_filter :paginar, only: [:index]

  skip_before_filter :authenticate_usuario!, only: [:index, :geo]
  skip_authorization_check only: [:index, :geo]
  skip_authorize_resource  only: [:index, :geo]

  # GET /calicatas
  # GET /calicatas.json
  # GET /series
  # GET /series.json
  def index
    @titulo = "Lista de #{@alias.pluralize}"
    respond_to do |format|
      format.html do
        if request.xhr?
          render :index,  layout: false,
                          locals: { calicatas: @calicatas.pagina(params[:pagina]) }
        end
      end
      format.json { render  json: @calicatas,
                            only: [ :id,
                                    :numero,
                                    :nombre,
                                    :ubicacion,
                                    :fecha      ] }
    end
  end

  # GET /calicatas/geo.json
  # GET /series/geo.json
  def geo
    respond_to do |format|
      format.json { render json: como_geojson(
                    @calicatas.reject { |c| c.ubicacion.try(:coordenadas).blank? },
                    :geometria)   }
    end
  end

  # GET /calicatas/1
  # GET /calicatas/1.json
  def show
    @calicata = Calicata.find(params[:id])
    @titulo = "Calicata #{@calicata.numero}"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calicata }
    end
  end

  # GET /calicatas/new
  # GET /calicatas/new.json
  def new
    @calicata = Calicata.new(params[:calicata])
    @titulo = 'Nueva calicata'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calicata }
    end
  end

  # GET /calicatas/1/edit
  def edit
    @calicata = Calicata.find(params[:id])
    @titulo = "Editando calicata #{@calicata.numero}"
  end

  # POST /calicatas
  # POST /calicatas.json
  def create

    @calicata = Calicata.new(params[:calicata])

    respond_to do |format|
      if @calicata.save
        format.html { redirect_to calicata_o_analisis,
                      notice: I18n.t('messages.created', model: 'Calicata') }
        format.json { render json: @calicata, status: :created, location: @calicata }
      else
        format.html { render action: "new" }
        format.json { render json: @calicata.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calicatas/1
  # PUT /calicatas/1.json
  def update

    # Para poder eliminar subclases de capacidad mediante los checkboxes, tengo
    # que garantizar que haya un arreglo vacío. El formulario devuelve nil por
    # la especificación de html, asique lo corrijo.
    begin
      params[:calicata][:capacidad_attributes][:subclase_ids] ||= []
    rescue
      # Nada que hacer porque no hay capacidad asociada.
    end

    @calicata = Calicata.find(params[:id])

    respond_to do |format|
      if @calicata.update_attributes(params[:calicata])
        format.html { redirect_to calicata_o_analisis,
                      notice: I18n.t('messages.updated', model: 'Calicata') }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @calicata.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calicatas/1
  # DELETE /calicatas/1.json
  def destroy
    @calicata = Calicata.find(params[:id])
    @calicata.destroy

    respond_to do |format|
      format.html { redirect_to calicatas_url }
      format.json { head :ok }
    end
  end

  #
  # Preparar los atributos a exportar/importar en CSV
  #
  def preparar_csv
    @atributos = Calicata.atributos_y_asociaciones :excepto =>
      [ :created_at, :updated_at, :adjuntos, :horizontes ]

    respond_to do |format|
      format.html
    end
  end

  def procesar_csv
    super(@calicatas, @alias.pluralize)
  end

protected

  # Prepara las variables para acceder desde la vista y armar las tablas de lookup
  #
  # * *Args*    :
  #   - ++ ->
  # * *Returns* :
  #   -
  # * *Raises* :
  #   - ++ ->
  #
  def armar_lookups
    @subclases = SubclaseDeCapacidad.all
    @clases = ClaseDeCapacidad.all
    @drenajes = Drenaje.all
    @relieves = Relieve.all
    @anegamientos = Anegamiento.all
    @posiciones = Posicion.all
    @pendientes = Pendiente.all
    @pedregosidades = Pedregosidad.all
    @escurrimientos = Escurrimiento.all
    @permeabilidades = Permeabilidad.all
    @sales = Sal.all
    @usos_de_la_tierra = UsoDeLaTierra.all
    @formas_de_limite = FormaDeLimite.all
    @tipos_de_limite = TipoDeLimite.all
    @texturas = TexturaDeHorizonte.all
    @formatos_de_coordenadas = FormatoDeCoordenadas.all
    @tipos_de_estructura = TipoDeEstructura.all
    @clases_de_estructura = ClaseDeEstructura.all
    @grados_de_estructura = GradoDeEstructura.all
  end

  def series_o_calicatas
    @calicatas = Calicata.scoped
    if request.fullpath =~ /^\/series/ then
      @calicatas = @calicatas.series
      @alias = 'serie'
    else
      @alias = 'calicata'
    end
  end

  def paginar
    @calicatas = @calicatas.pagina(params[:pagina])
  end

  def calicata_o_analisis
    params[:analisis].present? ? edit_calicata_analisis_index_path(@calicata) : @calicata
  end

end
