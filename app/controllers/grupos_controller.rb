# encoding: utf-8
class GruposController < AutorizadoController
  autocomplete :grupo, :descripcion, full: true

  has_scope :pagina, default: 1
  has_scope :per, as: :filas

  load_and_authorize_resource except: [:autocomplete_grupo_descripcion]

  with_options only: [:autocomplete_grupo_descripcion] do |o|
    o.skip_before_filter :authenticate_usuario!
    o.skip_authorization_check
  end

  def index
    @grupos = PaginadorDecorator.decorate apply_scopes(@grupos)

    respond_with @grupos
  end

  def new
    respond_with @grupo
  end

  def create
    @grupo.save
    respond_with @grupo
  end

  def show
    respond_with @grupo = @grupo.decorate
  end

  def update
    @grupo.update_attributes(grupo_params)

    respond_with @grupo
  end

  def destroy
    respond_with @grupo.destroy
  end

  def edit
    respond_with @grupo = @grupo.decorate
  end

  private

    def grupo_params
      params.require(:grupo).permit :descripcion, :codigo
    end
end
