# encoding: utf-8
class EquiposController < AutorizadoController
  has_scope :pagina, default: 1
  has_scope :per, as: :filas

  def index
    @equipos = PaginadorDecorator.decorate apply_scopes(@equipos)
    respond_with @equipos
  end

  def show
    respond_with @equipo = @equipo.decorate
  end

  def new
    respond_with @equipo 
  end

  def edit
    respond_with @equipo = @equipo.decorate
  end

  def create
    @equipo.save
    respond_with @equipo 
  end

  def update
    @equipo.update_attributes params[:equipo] 
    respond_with @equipo 
  end

  def destroy
    respond_with @equipo.destroy
  end
end
