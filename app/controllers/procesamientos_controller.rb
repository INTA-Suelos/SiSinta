class ProcesamientosController < AutorizadoController
  skip_authorization_check

  # Recibe una lista de perfiles preseleccionados, deja elegir el script
  def new
    @procesamiento = current_usuario.procesamientos.build
    @perfiles_rechazados = []
    # FIXME accessible_by
    @perfiles = Perfil.where(id: perfiles_seleccionados).limit 10
    self.perfiles_seleccionados = nil
  end

  # Revisa si hay perfiles que no cumplen los requisitos, de acuerdo al script
  def create
    @procesamiento = current_usuario.procesamientos.build procesamiento_params
    @perfiles_rechazados = []

    perfiles_params.each do |perfil_id|
      perfil = Perfil.find(perfil_id)

      if perfil.valid?
        @procesamiento.perfiles << perfil
      else
        @perfiles_rechazados << perfil
      end
    end

    # Por si volvemos a new
    @perfiles = @procesamiento.perfiles

    if @procesamiento.perfiles.any?
      opciones = { encoding: Encoding::UTF_8 }

      csv = Tempfile.new(["csv_#{@procesamiento.id}", '.csv'], '/tmp', opciones).tap do |file|
        file.write CSVSerializer.new(@procesamiento.perfiles.dup).as_csv(headers: true, base: Perfil)
        file.close
      end

      png = Tempfile.new(["procesamiento_#{@procesamiento.id}", '.png'], '/tmp')

      if system Rails.root.join('bin', 'slabs.R').to_s, csv.path, png.path
        @procesamiento.imagen = png
      end
    end

    # Si falla, responders lo redirige a new
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
end
