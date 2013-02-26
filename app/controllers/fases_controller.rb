# encoding: utf-8
class FasesController < AutorizadoController
  has_scope :pagina, default: 1
  has_scope :per, as: :filas

  def index
    @fases = PaginadorDecorator.decorate apply_scopes(@fases)

    respond_with @fases
  end

  # Extendemos +ApplicationController#autocompletar+ y definimos el modelo sobre
  # el que consultar, controlando el input del usuario.
  def autocompletar
    case params[:atributo]
      when 'nombre' then super(Fase, :nombre)
    end
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
    @fase.update_attributes(params[:fase])
    respond_with @fase
  end

  def destroy
    respond_with @fase.destroy
  end

  def edit
    respond_with @fase = @fase.decorate
  end

  private

    # Para los mensajes del flash de responders
    def interpolation_options
      { el_la: 'la' }
    end
end
