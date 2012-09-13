class ProyectosController < AutorizadoController

  skip_before_filter :authenticate_usuario!,  only: [:index, :show]
  skip_load_and_authorize_resource            only: [:index, :show]
  skip_authorization_check                    only: [:index, :show]

  # GET /proyectos
  # GET /proyectos.json
  def index
    @proyectos = Proyecto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proyectos }
    end
  end

  # GET /proyectos/1
  # GET /proyectos/1.json
  def show
    @proyecto = Proyecto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @proyecto }
    end
  end

  # GET /proyectos/new
  # GET /proyectos/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @proyecto }
    end
  end

  # GET /proyectos/1/edit
  def edit
  end

  # POST /proyectos
  # POST /proyectos.json
  def create
    respond_to do |format|
      if @proyecto.save
        format.html { redirect_to @proyecto, notice: 'Proyecto was successfully created.' }
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
        format.html { redirect_to @proyecto, notice: 'Proyecto was successfully updated.' }
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
end
