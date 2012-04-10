# encoding: utf-8
require 'csv'

class CalicatasController < AutorizadoController

  before_filter :armar_lookups
  before_filter :cargar_series_y_calicatas,
                :only => [:index, :geo, :preparar_csv, :procesar_csv]
  skip_before_filter :authenticate_usuario!, :only => [:index, :geo]

  # GET /calicatas
  # GET /calicatas.json
  # GET /series
  # GET /series.json
  def index
    @titulo = "Lista de #{@alias.pluralize}"
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

  # GET /calicatas/geo.json
  # GET /series/geo.json
  def geo
     respond_to do |format|
      format.json { render json: como_geojson(
                              @calicatas.reject { |c| c.ubicacion.coordenadas.nil? },
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
    @calicata = Calicata.new
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

  #
  # Extendemos +ApplicationController#ajax+ y definimos el modelo sobre el que
  # consultar.
  #
  def ajax
    super(Calicata)
  end

  #
  # Preparar los atributos a exportar/importar en CSV
  #
  def preparar_csv
    @atributos = Calicata.atributos_y_asociaciones :excepto => [:created_at, :updated_at, :fotos]

    respond_to do |format|
      format.html
    end
  end

  def procesar_csv
    @archivo = "#{@alias.pluralize}_#{Date.today.strftime('%Y-%m-%d')}.csv"

    @encabezado = true if params[:incluir_encabezado]

    @respuesta = CSV.generate(:headers => @encabezado) do |csv|
      @atributos = params[:atributos][:calicata].keys.flatten

      csv << @atributos if @encabezado

      @calicatas.each do |c|
        csv << c.como_arreglo(@atributos)
      end
    end

    send_data @respuesta, :filename => @archivo

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
    @sales = Sal.all
    @usos_tierra = UsoTierra.all
    @formas_limite = LimiteForma.all
    @tipos_limite = LimiteTipo.all
  end

  def cargar_series_y_calicatas
    if request.fullpath =~ /^\/series/ then
      @calicatas = Calicata.series.all(:order => 'fecha ASC')
      @alias = 'serie'
    else
      @calicatas = Calicata.all(:order => 'fecha ASC')
      @alias = 'calicata'
    end
  end
end
