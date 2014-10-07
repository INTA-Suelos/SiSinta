class BusquedasController < ApplicationController
  has_scope :search, as: :q, type: :hash, default: { }

  load_and_authorize_resource through: :current_usuario_o_anonimo
  skip_load_and_authorize_resource only: :show
  before_filter :cargar_busqueda_sin_usuario, only: :show

  def index
    @busquedas_publicas = Busqueda.publicas

    if usuario_signed_in?
      @busquedas_publicas = @busquedas_publicas.where('usuario_id <> ?', current_usuario.id)
    end

    respond_with(@busquedas)
  end

  def show
    respond_to do |format|
      format.html do
        params[:q] = @busqueda.consulta # TODO why?
        session[:volver_a] = busquedas_path
        redirect_to seleccionar_perfiles_path(
          q: @busqueda.consulta,
          busqueda: @busqueda.nombre
        )
      end
    end
  end

  def new
    @perfiles = Perfil.search
    @perfiles.build_grouping

    respond_with(@busqueda = @busqueda.decorate)
  end

  def edit
    @perfiles = Perfil.search(@busqueda.consulta)

    respond_with @busqueda = @busqueda.decorate
  end

  def create
    @busqueda.consulta = params.require(:q)
    @busqueda.usuario  = current_usuario

    respond_with(@busqueda) do |format|
      unless @busqueda.save
        # vuelve a new (necesita el objeto de búsqueda de nuevo)
        format.html do
          session[:volver_a] = new_busqueda_path
          redirect_to seleccionar_perfiles_path(q: params.require(:q))
        end
      end
    end
  end

  def update
    @busqueda.update_attributes busqueda_params

    respond_with(@busqueda)
  end

  def destroy
    @busqueda.destroy

    respond_with(@busqueda)
  end

  private

    def busqueda_params
      if usuario_signed_in?
        params.require(:busqueda).permit(:nombre, :publico)
      end
    end

    # Para los mensajes del flash de responders
    def interpolation_options
      { el_la: 'la' }
    end

    def current_usuario_o_anonimo
      current_usuario || Usuario.new
    end

    def cargar_busqueda_sin_usuario
      # No usar +load_and_authorize+ porque trata de cargar las listas públicas
      # por usuario
      @busqueda = Busqueda.accessible_by(current_ability).find(params[:id])
    end
end
