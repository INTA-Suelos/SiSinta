# encoding: utf-8
class AnalisisController < AutorizadoController
  responders :collection

  load_and_authorize_resource :perfil
  load_and_authorize_resource through: :perfil

  before_filter :decorar, only: [:index, :edit]

  def index
    respond_with @perfil, @analisis
  end

  def edit
    respond_with @perfil, @analisis
  end

  def update
    @perfil.update_attributes(params[:perfil])
    respond_with @perfil, @analisis
  end

  private

    def decorar
      @perfil = @perfil.decorate
    end
end
