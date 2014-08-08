# encoding: utf-8
class EquiposController < AutorizadoController
  has_scope :pagina, default: 1
  has_scope :per, as: :filas

  load_and_authorize_resource

  def index
    @equipos = PaginadorDecorator.decorate apply_scopes(@equipos)
    respond_with @equipos
  end

  def show
    respond_with @equipo = @equipo.decorate
  end

  def new
    respond_with @equipo = @equipo.decorate
  end

  def edit
    respond_with @equipo = @equipo.decorate
  end

  def create
    @equipo.save
    respond_with @equipo = @equipo.decorate
  end

  def update
    # Si falla, responders lo redirige a edit
    opciones = if @equipo.update_attributes(equipo_params)
      { location: mostrar_o_editar }
    else
      { }
    end

    respond_with (@equipo = @equipo.decorate), opciones
  end

  def destroy
    respond_with @equipo.destroy
  end

  private

    def equipo_params
      params.require(:equipo).permit(
        :nombre,
        nuevo_miembro: %i{ id nombre email },
        miembros_attributes: %i{ id _destroy }
      )
    end

    def mostrar_o_editar
      case params[:commit]
        when t('equipos.form.agregar_miembro')
          edit_equipo_path(@equipo)
        else
          # Nada, va a mostrar
      end
    end
end
