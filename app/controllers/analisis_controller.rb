# encoding: utf-8
class AnalisisController < AutorizadoController
  responders :collection

  # Salteo el default de AutorizadoController
  skip_load_and_authorize_resource
  # Cargo los análisis a través del perfil
  load_and_authorize_resource :perfil

  before_filter :decorar, only: [:index, :edit]

  def index
    @analisis = @perfil.analisis
    respond_with @perfil, @analisis
  end

  def edit
    @analisis = @perfil.analisis
    respond_with @perfil, @analisis
  end

  def update
    @perfil.update_attributes(params[:perfil])
    @analisis = @perfil.analisis.first
    respond_with @perfil, @analisis
  end

  private

    def decorar
      @perfil = @perfil.decorate
    end
end
