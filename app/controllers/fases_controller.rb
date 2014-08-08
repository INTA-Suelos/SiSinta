# encoding: utf-8
class FasesController < AutorizadoController
  autocomplete :fase, :nombre, full: true

  has_scope :pagina, default: 1
  has_scope :per, as: :filas

  load_and_authorize_resource except: [:autocomplete_fase_nombre]

  with_options only: [:autocomplete_fase_nombre] do |o|
    o.skip_before_filter :authenticate_usuario!
    o.skip_authorization_check
  end

  def index
    @fases = PaginadorDecorator.decorate apply_scopes(@fases)

    respond_with @fases
  end

  def new
    respond_with @fase
  end

  def create
    @fase.save
    respond_with @fase
  end

  def show
    respond_with @fase = @fase.decorate
  end

  def update
    @fase.update_attributes(fase_params)
    respond_with @fase
  end

  def destroy
    respond_with @fase.destroy
  end

  def edit
    respond_with @fase = @fase.decorate
  end

  private

    def fase_params
      params.require(:fase).permit :nombre, :codigo
    end

    # Para los mensajes del flash de responders
    def interpolation_options
      { el_la: 'la' }
    end
end
