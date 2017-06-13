class AdjuntosController < AutorizadoController
  responders :collection

  # Se permite el acceso a los adjuntos públicos (o sea de perfiles públicos)
  skip_before_filter :authenticate_usuario!, only: [:index, :show, :descargar]

  # Carga los adjuntos a través del perfil
  load_and_authorize_resource :perfil
  load_and_authorize_resource through: :perfil

  before_filter :decorar, only: [:index, :show, :edit, :new]

  def index
    respond_with @perfil, @adjuntos
  end

  def show
    respond_with @perfil, @adjunto
  end

  def update
    @adjunto.update_attributes(adjunto_params)
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
    @adjunto.usuario = current_usuario

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

    def adjunto_params
      params.require(:adjunto).permit(
        :notas, :archivo
      )
    end

    def decorar
      @perfil = @perfil.decorate
      @adjunto = @adjunto.decorate unless @adjunto.nil?
      @adjuntos = PaginadorDecorator.decorate(@adjuntos) unless @adjuntos.nil?
    end
end
