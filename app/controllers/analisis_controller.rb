# encoding: utf-8
class AnalisisController < AutorizadoController

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
    # TODO sort por profundidad de horizonte
    @analisis = @calicata.analisis.sort
  end

  # PUT /calicata/1/analisis
  # PUT /calicata/1/analisis.json
  def update
    respond_to do |format|
      if @calicata.update_attributes(params[:calicata])
        format.html { redirect_to calicata_analisis_index_path(@calicata),
                      notice: I18n.t('messages.updated', model: 'Analisis') }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @calicata.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analisis/1
  # DELETE /analisis/1.json
  def destroy
    @analisis = Analisis.find(params[:id])
    @analisis.destroy

    respond_to do |format|
      format.html { redirect_to calicata_analisis_index_path(@calicata) }
      format.json { head :ok }
    end
  end

end
