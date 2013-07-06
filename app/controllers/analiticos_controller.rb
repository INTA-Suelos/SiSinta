# encoding: utf-8
class AnaliticosController < AutorizadoController
  responders :collection

  skip_before_filter :authenticate_usuario!,  only: :index

  # Carga los datos analíticos a través del perfil
  load_and_authorize_resource :perfil
  load_and_authorize_resource through: :perfil

  before_filter :decorar, only: [:index, :edit]

  def index
    respond_with @perfil, @analiticos
  end

  private

    def decorar
      @perfil = @perfil.decorate
    end
end
