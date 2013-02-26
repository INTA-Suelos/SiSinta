# encoding: utf-8
class GruposController < AutorizadoController
  has_scope :pagina, default: 1
  has_scope :per, as: :filas

  def index
    @grupos = PaginadorDecorator.decorate apply_scopes(@grupos)

    respond_with @grupos
  end

  # Extendemos +ApplicationController#autocompletar+ y definimos el modelo sobre
  # el que consultar, controlando el input del usuario.
  def autocompletar
    case params[:atributo]
      when 'descripcion' then super(Grupo, :descripcion)
    end
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
    @grupo.update_attributes(params[:grupo])

    respond_with @grupo
  end

  def destroy
    respond_with @grupo.destroy
  end

  def edit
    respond_with @grupo = @grupo.decorate
  end
end
