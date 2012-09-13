# encoding: utf-8
class AnalisisController < AutorizadoController

  # La acción +index+ carga sus propios análisis
  load_and_authorize_resource :perfil
  skip_load_and_authorize_resource
  skip_authorization_check

  # GET /analisis
  # GET /analisis.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @perfil.analisis }
    end
  end

  # PUT /perfil/1/analisis
  # PUT /perfil/1/analisis.json
  def update
    respond_to do |format|
      if @perfil.update_attributes(params[:perfil])
        format.html { redirect_to perfil_analisis_index_path(@perfil),
                      notice: I18n.t('messages.updated', model: 'Analisis') }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @perfil.errors, status: :unprocessable_entity }
      end
    end
  end

end
