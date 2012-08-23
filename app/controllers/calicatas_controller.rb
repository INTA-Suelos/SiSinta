# encoding: utf-8
class CalicatasController < AutorizadoController

  before_filter :preparar,  only: [:index, :geo, :preparar_csv, :procesar_csv]
  before_filter :ordenar,   only: [:index, :geo, :preparar_csv, :procesar_csv]
  before_filter :paginar,   only: [:index]

  # Las acciones +index+ y +geo+ funcionan anónimamente
  skip_before_filter :authenticate_usuario!,  only: [:index, :geo]
  skip_load_and_authorize_resource            only: [:index, :geo]
  skip_authorization_check                    only: [:index, :geo]

  # GET /calicatas
  # GET /calicatas.json
  def index
    @titulo = "Lista de calicatas"
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
  def geo
    respond_to do |format|
      format.json { render json: como_geojson(
                    @calicatas.reject { |c| c.ubicacion.try(:coordenadas).blank? },
                    :geometria)   }
    end
  end

  # Extendemos +ApplicationController#autocompletar+ y definimos el modelo sobre
  # el que consultar, controlando el input del usuario.
  #
  def autocompletar
    case params[:atributo]
      when 'nombre'         then super(Calicata, :nombre)
      when 'numero'         then super(Calicata, :numero)
      when 'etiquetas'      then super(Calicata.tags(on: :etiquetas), :name)
      when 'reconocedores'  then super(Calicata.tags(on: :reconocedores), :name)
    end
  end

  # GET /calicatas/1
  # GET /calicatas/1.json
  def show
    @calicata = CalicataDecorator.new(@calicata)
    @titulo = "Calicata #{@calicata.numero}"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calicata }
    end
  end

  # GET /calicatas/new
  # GET /calicatas/new.json
  def new
    @calicata = CalicataDecorator.new(@calicata)
    @titulo = 'Nueva calicata'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calicata }
    end
  end

  # GET /calicatas/1/edit
  def edit
    @calicata = CalicataDecorator.new(@calicata)
    @titulo = "Editando calicata #{@calicata.numero}"
  end

  # POST /calicatas
  # POST /calicatas.json
  def create
    @calicata.usuario = current_usuario

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
    @calicata.destroy

    respond_to do |format|
      format.html { redirect_to calicatas_url }
      format.json { head :ok }
    end
  end

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
    super(@calicatas, 'calicatas')
  end

protected

  # Prepara el scope para la lista de calicatas
  def preparar
    @calicatas ||= Calicata.scoped
    @calicatas = @calicatas.search(params[:q]).result if params[:q].present?
  end

  # Ordena los resultados según las columnas de la lista. Si son columnas de
  # texto, las normaliza a lowercase.
  def ordenar
    case @metodo = metodo_de_ordenamiento
    when 'ubicacion'
      @calicatas =
        @calicatas.joins(:ubicacion)
                  .select('calicatas.*, ubicaciones.descripcion')
      @metodo = 'lower(ubicaciones.descripcion)'
    when 'nombre', 'numero'
      @metodo = "lower(#{@metodo})"
    else
      # A los date y boolean no se les aplica lower()
    end
    @calicatas = @calicatas.order("#{@metodo} #{direccion_de_ordenamiento}")
  end

  # Agrega la paginación al scope en curso
  def paginar
    @calicatas = @calicatas.pagina(params[:pagina])
  end

  # Determina la ruta a la que reenvia
  def calicata_o_analisis
    params[:analisis].present? ? edit_calicata_analisis_index_path(@calicata) : @calicata
  end

  # Revisa el input del usuario para los métodos de ordenamiento. Ordena según
  # la +fecha+ por default.
  def metodo_de_ordenamiento
    %w[ fecha nombre ubicacion numero modal
      ].include?(params[:por]) ? params[:por] : 'fecha'
  end

end
