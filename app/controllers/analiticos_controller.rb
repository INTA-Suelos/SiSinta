class AnaliticosController < AutorizadoController
  responders :collection

  skip_before_filter :authenticate_usuario!,  only: :index

  before_filter :seleccionar_ficha, only: :index

  # Carga los datos analíticos a través del perfil
  load_and_authorize_resource :perfil
  load_and_authorize_resource through: :perfil

  def index
    if @perfil.horizontes.empty?
      flash[:alert] = t('.sin_horizontes')
      redirect_to @perfil
    else
      respond_with @perfil, @analiticos
    end
  end
end
