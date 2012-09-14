# encoding: utf-8
class AdjuntosController < AutorizadoController

  before_filter :cargar_perfil

  def show
    @adjunto = Adjunto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adjunto }
    end
  end

  def index
    @adjuntos = @perfil.adjuntos

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adjuntos }
    end
  end

  def update
    @adjunto = Adjunto.find(params[:id])

    respond_to do |format|
      if @adjunto.update_attributes(params[:adjunto])
        format.html { redirect_to perfil_adjuntos_path(@perfil),
                      notice: I18n.t('messages.updated', model: 'Adjunto') }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @perfil.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @adjunto = Adjunto.find(params[:id])
    @adjunto.destroy

    respond_to do |format|
      format.html { redirect_to perfil_adjuntos_path(@perfil) }
      format.json { head :ok }
    end
  end

  def new
    @adjunto = Adjunto.new
    @titulo = 'Subir adjunto'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: [@perfil, @adjunto] }
    end
  end

  def create
    @adjunto = Adjunto.new(params[:adjunto])

    respond_to do |format|
      if @perfil.adjuntos << @adjunto
        format.html { redirect_to perfil_adjuntos_path(@perfil),
                      notice: I18n.t('messages.created', model: 'Adjunto') }
        format.json { render json: @adjunto, status: :created,
                      location: perfil_adjuntos_path(@perfil) }
      else
        format.html { render action: "new" }
        format.json { render json: @adjunto.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @adjunto = Adjunto.find(params[:id])
    @titulo = "Editando adjunto de perfil #{@perfil.numero}"
  end

  def descargar
    @adjunto = Adjunto.find(params[:id])

    send_file @adjunto.archivo.path, type: @adjunto.archivo_content_type, disposition: 'inline'
  end
end
