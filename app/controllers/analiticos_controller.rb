# encoding: utf-8
class AnaliticosController < AutorizadoController
  responders :collection

  # Salteo el default de AutorizadoController
  skip_load_and_authorize_resource
  # Cargo los datos analíticos a través del perfil
  load_and_authorize_resource :perfil

  before_filter :decorar, only: [:index, :edit]

  def index
    @analiticos = @perfil.analiticos
    respond_with @perfil, @analiticos
  end

  def editar_todos
    @analiticos = @perfil.analiticos
    respond_with @perfil, @analiticos
  end

  def update_todos
    @perfil.update_attributes(params[:perfil])
    @analiticos = @perfil.analiticos.first
    respond_with @perfil, @analiticos
  end

  private

    def decorar
      @perfil = @perfil.decorate
    end
end
