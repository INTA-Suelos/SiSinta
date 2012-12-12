# encoding: utf-8
class ProyectosController < AutorizadoController

  # Las acciones +index+ y +show+ funcionan anónimamente
  skip_before_filter :authenticate_usuario!,  only: [:index, :show]
  skip_load_and_authorize_resource            only: [:index, :show]
  skip_authorization_check                    only: [:index, :show]

  before_filter :asociar_perfiles,            only: [:update]

  # GET /proyectos
  # GET /proyectos.json
  def index
    @proyectos = Proyecto.all
    @titulo = "Proyectos"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proyectos }
    end
  end

  # GET /proyectos/1
  # GET /proyectos/1.json
  def show
    @proyecto = Proyecto.find(params[:id]).decorate
    @titulo = @proyecto.nombre

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @proyecto }
    end
  end

  # GET /proyectos/new
  # GET /proyectos/new.json
  def new
    @busqueda = Perfil.search
    @titulo = 'Nuevo proyecto'
    @proyecto = ProyectoDecorator.decorate(@proyecto)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @proyecto }
    end
  end

  # GET /proyectos/1/edit
  def edit
    @busqueda = Perfil.search
    @titulo = "Editando #{@proyecto.nombre}"
    @proyecto = ProyectoDecorator.decorate(@proyecto)
  end

  # POST /proyectos
  # POST /proyectos.json
  def create
    respond_to do |format|
      if @proyecto.save
        format.html { buscar_perfiles_o_guardar }
        format.json { render json: @proyecto, status: :created, location: @proyecto }
      else
        format.html { render action: "new" }
        format.json { render json: @proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /proyectos/1
  # PUT /proyectos/1.json
  def update
    respond_to do |format|
      if @proyecto.update_attributes(params[:proyecto])
        format.html { buscar_perfiles_o_guardar }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proyectos/1
  # DELETE /proyectos/1.json
  def destroy
    @proyecto.destroy

    respond_to do |format|
      format.html { redirect_to proyectos_url }
      format.json { head :no_content }
    end
  end

  private

    def asociar_perfiles
      if params[:perfil_ids]
        # Agregamos sólo los ids que no estaban ya
        nuevos = params[:perfil_ids].collect {|id| id.to_i } - @proyecto.perfil_ids
        @proyecto.perfiles << Perfil.find(nuevos)
      end
    end

    def buscar_perfiles_o_guardar
      case params[:commit]
      when 'Buscar'
        session[:origen] = proyecto_path(@proyecto)
        redirect_to perfiles_path(format: :seleccion, q: params[:q])
      else
        redirect_to @proyecto, notice: I18n.t("messages.#{params[:action]}d", model: 'Proyecto')
      end
    end

end
