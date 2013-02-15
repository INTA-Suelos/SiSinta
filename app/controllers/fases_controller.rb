# encoding: utf-8
class FasesController < AutorizadoController

  # GET /fases
  # GET /fases.json
  def index
    @fases = Fase.all(:order => 'nombre ASC')

    respond_to do |format|
      format.html # index.html.{erb,haml}
      format.json { render  json: @fases }
    end
  end

  #
  # Extendemos +ApplicationController#autocompletar+ y definimos el modelo sobre
  # el que consultar, controlando el input del usuario.
  #
  def autocompletar
    case params[:atributo]
      when 'nombre' then super(Fase, :nombre)
    end
  end

  # GET /fases/new
  # GET /fases/new.json
  def new
    @fase = Fase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fase }
    end
  end

  # POST /fases
  # POST /fases.json
  def create
    @fase = Fase.new(params[:fase])

    respond_to do |format|
      if @fase.save
        format.html { redirect_to @fase,
                      notice: I18n.t('messages.created', model: 'Fase') }
        format.json { render json: @fase, status: :created, location: @fase }
      else
        format.html { render action: "new" }
        format.json { render json: @fase.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /fases/1
  # GET /fases/1.json
  def show
    @fase = Fase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fase }
    end
  end

  # PUT /fases/1
  # PUT /fases/1.json
  def update
    @fase = Fase.find(params[:id])

    respond_to do |format|
      if @fase.update_attributes(params[:fase])
        format.html { redirect_to @fase,
                      notice: I18n.t('messages.updated', model: 'Fase') }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fases/1
  # DELETE /fases/1.json
  def destroy
    @fase = Fase.find(params[:id])
    @fase.destroy

    respond_to do |format|
      format.html { redirect_to fases_url }
      format.json { head :ok }
    end
  end

  # GET /fases/1/edit
  def edit
    @fase = Fase.find(params[:id])
  end

end
