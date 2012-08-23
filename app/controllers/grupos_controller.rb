# encoding: utf-8
class GruposController < AutorizadoController

  # GET /grupos
  # GET /grupos.json
  def index
    @grupos = Grupo.all(:order => 'descripcion ASC')

    respond_to do |format|
      format.html # index.html.{erb,haml}
      format.json { render  json: @grupos }
    end
  end

  #
  # Extendemos +ApplicationController#autocompletar+ y definimos el modelo sobre
  # el que consultar, controlando el input del usuario.
  #
  def autocompletar
    case params[:atributo]
      when 'descripcion' then super(Grupo, :descripcion)
    end
  end

  # GET /grupos/new
  # GET /grupos/new.json
  def new
    @grupo = Grupo.new
    @titulo = 'Nuevo grupo'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @grupo }
    end
  end

  # POST /grupos
  # POST /grupos.json
  def create
    @grupo = Grupo.new(params[:grupo])

    respond_to do |format|
      if @grupo.save
        format.html { redirect_to @grupo,
                      notice: I18n.t('messages.created', model: 'Grupo') }
        format.json { render json: @grupo, status: :created, location: @grupo }
      else
        format.html { render action: "new" }
        format.json { render json: @grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /grupos/1
  # GET /grupos/1.json
  def show
    @grupo = Grupo.find(params[:id])
    @titulo = @grupo.codigo

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @grupo }
    end
  end

  # PUT /grupos/1
  # PUT /grupos/1.json
  def update
    @grupo = Grupo.find(params[:id])

    respond_to do |format|
      if @grupo.update_attributes(params[:grupo])
        format.html { redirect_to @grupo,
                      notice: I18n.t('messages.updated', model: 'Grupo') }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grupos/1
  # DELETE /grupos/1.json
  def destroy
    @grupo = Grupo.find(params[:id])
    @grupo.destroy

    respond_to do |format|
      format.html { redirect_to grupos_url }
      format.json { head :ok }
    end
  end

  # GET /grupos/1/edit
  def edit
    @grupo = Grupo.find(params[:id])
    @titulo = "Editando grupo #{@grupo.codigo}"
  end

end
