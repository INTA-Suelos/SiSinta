class BusquedasController < ApplicationController
  has_scope :search, as: :q, type: :hash, default: { }

  load_and_authorize_resource

  def index
    respond_with(@busquedas)
  end

  def show
    respond_to do |format|
      format.html do
        params[:q] = @busqueda.consulta
        redirect_to seleccionar_perfiles_path(q: @busqueda.consulta)
      end
    end
  end

  def new
    @perfiles = Perfil.search
    respond_with(@busqueda)
  end

  def edit
    @perfiles = Perfil.search(@busqueda.consulta)
  end

  def create
    @busqueda.consulta = params[:q]
    @busqueda.usuario  = current_usuario

    respond_with(@busqueda) do |format|
      unless @busqueda.save
        # vuelve a new (necesita el objeto de búsqueda de nuevo)
        format.html do
          @perfiles = Perfil.search params[:q]
        end
      end
    end
  end

  def update
    @busqueda.update_attributes(params[:busqueda])
    respond_with(@busqueda)
  end

  def destroy
    @busqueda.destroy
    respond_with(@busqueda)
  end

  private

    # Para los mensajes del flash de responders
    def interpolation_options
      { el_la: 'la' }
    end
end
