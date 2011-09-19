class ObservacionController < ApplicationController
  layout :ficha_observacion

  # GET /observacion
  # GET /observacion.json
  def index
    @observacion = Observacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @observacion }
    end
  end

  # GET /observacion/1
  # GET /observacion/1.json
  def show
    @observacion = Observacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @observacion }
    end
  end

  # GET /observacion/new
  # GET /observacion/new.json
  def new
    @observacion = Observacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @observacion }
    end
  end

  # GET /observacion/1/edit
  def edit
    @observacion = Observacion.find(params[:id])
  end

  # POST /observacion
  # POST /observacion.json
  def create
    @observacion = Observacion.new(params[:observacion])

    respond_to do |format|
      if @observacion.save
        format.html { redirect_to @observacion, notice: 'observacion was successfully created.' }
        format.json { render json: @observacion, status: :created, location: @observacion }
      else
        format.html { render action: "new" }
        format.json { render json: @observacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /observacion/1
  # PUT /observacion/1.json
  def update
    @observacion = Observacion.find(params[:id])

    respond_to do |format|
      if @observacion.update_attributes(params[:observacion])
        format.html { redirect_to @observacion, notice: 'observacion was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @observacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observacion/1
  # DELETE /observacion/1.json
  def destroy
    @observacion = Observacion.find(params[:id])
    @observacion.destroy

    respond_to do |format|
      format.html { redirect_to observacion_index_url }
      format.json { head :ok }
    end
  end

  private
    def ficha_observacion
      @current_user.usar_ficha_simple? ? 'observacion_simple' : 'observacion_completa'
    end
end
