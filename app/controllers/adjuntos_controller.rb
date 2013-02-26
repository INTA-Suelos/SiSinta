# encoding: utf-8
class AdjuntosController < AutorizadoController
  responders :collection

  load_and_authorize_resource :perfil
  load_and_authorize_resource through: :perfil

  before_filter :decorar, only: [:index, :show, :edit, :new]

  def index
    @adjuntos = @perfil.adjuntos
    respond_with @perfil, @adjuntos
  end

  def show
    respond_with @perfil, @adjunto
  end

  def update
    @adjunto.update_attributes(params[:adjunto])
    respond_with @perfil, @adjunto
  end

  def destroy
    @adjunto.destroy
    respond_with @perfil, @adjunto
  end

  def new
    respond_with @perfil, @adjunto
  end

  def create
    @perfil.adjuntos << @adjunto
    respond_with @perfil, @adjunto
  end

  def edit
    respond_with @perfil, @adjunto
  end

  def descargar
    send_file @adjunto.archivo.path, type: @adjunto.archivo_content_type, disposition: 'inline'
  end

  private

    def decorar
      @perfil = @perfil.decorate
    end
end
