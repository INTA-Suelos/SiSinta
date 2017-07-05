class ProcesamientosController < AutorizadoController
  skip_authorization_check

  before_action :ordenar, only: :index

  def index
  end

  # Recibe una lista de perfiles preseleccionados, deja elegir el script
  def new
    @procesamiento = current_usuario.procesamientos.build
    @perfiles_rechazados = []
    # FIXME accessible_by

    @perfiles = Perfil.where(id: perfiles_seleccionados)
    self.perfiles_seleccionados = nil
  end

  # Revisa si hay perfiles que no cumplen los requisitos, de acuerdo al script
  def create
    @procesamiento = current_usuario.procesamientos.build procesamiento_params
    # FIXME Implementar
    @perfiles_rechazados = []

    @procesamiento.perfiles << Perfil.where(id: perfiles_params)

    # Por si volvemos a new
    @perfiles = @procesamiento.perfiles

    if @procesamiento.save && @procesamiento.perfiles.any?
      ProcesarErreJob.perform_later @procesamiento
    end

    opciones = if @procesamiento.save
      { location: procesamiento_path(@procesamiento) }
    else
      { }
    end

    respond_with @procesamiento, opciones
  end

  def edit
    @procesamiento = current_usuario.procesamientos.find(params[:id])
    @perfiles = @procesamiento.perfiles
    @perfiles_rechazados = []
  end

  def update
    @procesamiento = current_usuario.procesamientos.find(params[:id])
    @perfiles_rechazados = []

    @procesamiento.perfiles = Perfil.where(id: perfiles_params)

    # Por si volvemos a new
    @perfiles = @procesamiento.perfiles

    if @procesamiento.update(procesamiento_params) && @procesamiento.perfiles.any?
      ProcesarErreJob.perform_later @procesamiento
    end

    opciones = if @procesamiento.save
      { location: procesamiento_path(@procesamiento) }
    else
      { }
    end

    respond_with @procesamiento, opciones
  end

  def show
    @procesamiento = Procesamiento.find(params[:id])
  end

  def destroy
    @procesamiento = Procesamiento.find(params[:id])

    respond_with @procesamiento.destroy
  end

  protected

  def procesamiento_params
    params.require(:procesamiento).permit(
      :metodologia, perfiles_attributes: %i{ id anular }
    )
  end

  def perfiles_params
    if params[:seleccionados] && params[:seleccionados][:perfiles_attributes]
      # Remover de los seleccionados los que hayan sido eliminados con 'x'
      # FIXME Emprolijar
      params[:seleccionados][:perfiles_attributes].values.select { |p| p[:anular].nil? }.map(&:values).flatten
    end
  end

  # Revisa el input del usuario para los métodos de ordenamiento. Ordena según
  # +created_at+ por default.
  def metodo_de_ordenamiento
    %w[
        created_at metodologia
      ].include?(params[:por]) ? params[:por] : 'created_at'
  end

  def ordenar
    @procesamientos = Procesamiento.all.reorder(
      metodo_de_ordenamiento => direccion_de_ordenamiento
    )
  end
end
