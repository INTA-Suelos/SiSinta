# encoding: utf-8
class AnaliticosController < AutorizadoController
  responders :collection

  # Carga los datos analíticos a través del perfil
  load_and_authorize_resource :perfil
  load_and_authorize_resource through: :perfil

  before_filter :decorar, only: [:index, :edit]

  def index
    respond_with @perfil, @analiticos
  end

  def editar_todos
    respond_with @perfil, @analiticos
  end

  def update_todos
    @perfil.update_attributes(params[:perfil])
    respond_with @perfil, @analiticos,
      location: perfil_analiticos_path(@perfil),
      notice: t('flash.analiticos.update_todos.notice')
  end

  private

    def decorar
      @perfil = @perfil.decorate
    end
end
