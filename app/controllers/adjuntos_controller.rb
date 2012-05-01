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
    @adjunto = Adjunto.find(params[:id])

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

  def new
    @adjunto = Adjunto.new
    @titulo = 'Subir adjunto'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: [@calicata, @adjunto] }
    end
  end

  def create
    @adjunto = Adjunto.new(params[:adjunto])

    respond_to do |format|
      if @calicata.adjuntos << @adjunto
        format.html { redirect_to calicata_adjuntos_path(@calicata),
                      notice: I18n.t('messages.created', model: 'Adjunto') }
        format.json { render json: @adjunto, status: :created,
                      location: calicata_adjuntos_path(@calicata) }
      else
        format.html { render action: "new" }
        format.json { render json: @adjunto.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @adjunto = Adjunto.find(params[:id])
    @titulo = "Editando adjunto de calicata #{@calicata.numero}"
  end

  def descargar
    @adjunto = Adjunto.find(params[:id])

    send_file @adjunto.archivo.path, type: @adjunto.archivo_content_type, disposition: 'inline'
  end
end
