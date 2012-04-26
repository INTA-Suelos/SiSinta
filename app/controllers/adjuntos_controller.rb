class AdjuntosController < ApplicationController

  before_filter :cargar_calicata

  def show
    @adjunto = Adjunto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adjunto }
    end
  end

  def index
    @adjuntos = @calicata.adjuntos

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adjuntos }
    end
  end

  def update
    respond_to do |format|
      if @adjunto.update_attributes(params[:adjunto])
        format.html { redirect_to calicata_adjuntos_path(@calicata),
                      notice: I18n.t('messages.updated', model: 'Adjunto') }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @calicata.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @adjunto = Adjunto.find(params[:id])
    @adjunto.destroy

    respond_to do |format|
      format.html { redirect_to calicata_adjuntos_path(@calicata) }
      format.json { head :ok }
    end
  end

end
