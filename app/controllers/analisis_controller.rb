class AnalisisController < ApplicationController

  before_filter :cargar_calicata

  # GET /analisis
  # GET /analisis.json
  def index
    @analisis = @calicata.analisis

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @analisis }
    end
  end

  # GET /analisis/1
  # GET /analisis/1.json
  def show
    @analisis = Analisis.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @analisis }
    end
  end

  # GET /analisis/edit
  def edit
    @analisis = @calicata.analisis
  end

  # PUT /analisis/1
  # PUT /analisis/1.json
  def update
    @analisis = Analisis.find(params[:id])

    respond_to do |format|
      if @analisis.update_attributes(params[:analisis])
        format.html { redirect_to [@calicata, @analisis], notice: 'Analisis was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @analisis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analisis/1
  # DELETE /analisis/1.json
  def destroy
    @analisis = Analisis.find(params[:id])
    @analisis.destroy

    respond_to do |format|
      format.html { redirect_to calicata_analisis_index_url }
      format.json { head :ok }
    end
  end

protected

  # Carga la calicata a la que pertenecen los análisis
  #
  def cargar_calicata
    @calicata = Calicata.find(params[:calicata_id])
  end

end
