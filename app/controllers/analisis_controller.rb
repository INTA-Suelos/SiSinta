# encoding: utf-8
class AnalisisController < AutorizadoController

  # La accioón +index+ carga sus propios análisis
  load_and_authorize_resource :calicata
  skip_load_and_authorize_resource
  skip_authorization_check

  # GET /analisis
  # GET /analisis.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @analisis }
    end
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

end
