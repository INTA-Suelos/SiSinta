class CalicatasController < AutorizadoController

  # GET /calicatas
  # GET /calicatas.json
  def index
    @calicatas = Calicata.all(:order => 'fecha ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calicatas }
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
    preparar_nueva_calicata

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calicata }
    end
  end

  # GET /calicatas/1/edit
  def edit
    @calicata = Calicata.find(params[:id])
  end

  # POST /calicatas
  # POST /calicatas.json
  def create
    @calicata = Calicata.new(params[:calicata])

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
    @calicata = Calicata.find(params[:id])

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

protected

  def preparar_nueva_calicata
    @calicata = Calicata.new
    @calicata.capacidad ||= Capacidad.new
    @calicata.fase ||= Fase.new
    @calicata.serie ||= Serie.new
    @calicata.paisaje ||= Paisaje.new
    @calicata.escurrimiento ||= Escurrimiento.new
    @calicata.pendiente ||= Pendiente.new
    @calicata.permeabilidad ||= Permeabilidad.new
    @calicata.relieve ||= Relieve.new
    @calicata.anegamiento ||= Anegamiento.new
    @calicata.posicion ||= Posicion.new
    @calicata.drenaje ||= Drenaje.new

    # Para los dropbox
    @clases = CapacidadClase.all
    @subclases = CapacidadSubclase.all
    @escurrimientos = Escurrimiento.all
    @pendientes = Pendiente.all
    @permeabilidades = Permeabilidad.all
    @posiciones = Posicion.all
    @relieves = Relieve.all
    @anegamientos = Anegamiento.all
    @drenajes = Drenaje.all
  end

end
