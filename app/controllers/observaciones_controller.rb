class ObservacionesController < ApplicationController
  layout :ficha_observacion

  # GET /observaciones
  # GET /observaciones.json
  def index
    @observaciones = Observacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @observaciones }
    end
  end

  # GET /observaciones/1
  # GET /observaciones/1.json
  def show
    @observacion = Observacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @observacion }
    end
  end

  # GET /observaciones/new
  # GET /observaciones/new.json
  def new
    @observacion = Observacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @observacion }
    end
  end

  # GET /observaciones/1/edit
  def edit
    @observacion = Observacion.find(params[:id])
  end

  # POST /observaciones
  # POST /observaciones.json
  def create
    @observacion = Observacion.new(params[:observacion])

    respond_to do |format|
      if @observacion.save
        format.html { redirect_to @observacion, notice: 'Observacion was successfully created.' }
        format.json { render json: @observacion, status: :created, location: @observacion }
      else
        format.html { render action: "new" }
        format.json { render json: @observacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /observaciones/1
  # PUT /observaciones/1.json
  def update
    @observacion = Observacion.find(params[:id])

    respond_to do |format|
      if @observacion.update_attributes(params[:observacion])
        format.html { redirect_to @observacion, notice: 'Observacion was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @observacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observaciones/1
  # DELETE /observaciones/1.json
  def destroy
    @observacion = Observacion.find(params[:id])
    @observacion.destroy

    respond_to do |format|
      format.html { redirect_to observaciones_url }
      format.json { head :ok }
    end
  end

  private
    def ficha_observacion
      self.usuario_activo.usar_ficha_simple? ? 'observacion_simple' : 'observacion_completa'
    end
end
