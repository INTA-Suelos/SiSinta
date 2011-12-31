class CalicatasController < AutorizadoController

  before_filter :armar_lookups
  skip_before_filter :authenticate_usuario!, :only => :index

  # GET /calicatas
  # GET /calicatas.json
  # GET /series
  # GET /series.json
  def index
    if request.fullpath =~ /^\/series/ then
      @calicatas = Calicata.series.all(:order => 'fecha ASC')
      @alias = 'serie'
    else
      @calicatas = Calicata.all(:order => 'fecha ASC')
      @alias = 'calicata'
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render  json: @calicatas,
                            only: [ :id,
                                    :numero,
                                    :nombre,
                                    :ubicacion,
                                    :fecha      ] }
    end
  end

  # GET /calicatas/1
  # GET /calicatas/1.json
  def show
    @calicata = Calicata.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calicata }
    end
  end

  # GET /calicatas/new
  # GET /calicatas/new.json
  def new
    @calicata.preparar

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calicata }
    end
  end

  # GET /calicatas/1/edit
  def edit
    @calicata = Calicata.find(params[:id])
    @calicata.preparar
  end

  # POST /calicatas
  # POST /calicatas.json
  def create
    @calicata = Calicata.new(params[:calicata])
    @calicata.preparar

    respond_to do |format|
      if @calicata.save
        format.html { redirect_to @calicata, notice: 'Calicata was successfully created.' }
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
    
    # Para poder eliminar subclases de capacidad mediante los checkboxes, tengo que forzar que
    # haya un arreglo vacío cuando es nil. El formulario devuelve nil por la especificación de html.
    # Los tests fallan si no recupero la excepción de los nils.
    begin
      params[:calicata][:capacidad_attributes][:subclase_ids] ||= []
    rescue
    end

    @calicata = Calicata.find(params[:id])
    @calicata.preparar

    respond_to do |format|
      if @calicata.update_attributes(params[:calicata])
        format.html { redirect_to @calicata, notice: 'Calicata was successfully updated.' }
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

  # GET /calicatas/ajax/:atributo
  def ajax
    render json: lista_para_autocompletar(Calicata, params[:atributo])
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
    @subclases = CapacidadSubclase.all
    @clases = CapacidadClase.all
    @drenajes = Drenaje.all
    @relieves = Relieve.all
    @anegamientos = Anegamiento.all
    @posiciones = Posicion.all
    @pendientes = Pendiente.all
    @escurrimientos = Escurrimiento.all
    @permeabilidades = Permeabilidad.all
  end
end
