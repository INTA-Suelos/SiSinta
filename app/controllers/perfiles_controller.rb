# encoding: utf-8
class PerfilesController < AutorizadoController

  before_filter :preparar,  only: [:index, :geo, :seleccionar,
                                   :preparar_csv, :procesar_csv ]
  before_filter :ordenar,   only: [:index, :geo, :seleccionar,
                                   :preparar_csv, :procesar_csv ]
  before_filter :paginar,   only: [:index]

  # Las acciones +index+ y +geo+ funcionan anónimamente
  skip_before_filter :authenticate_usuario!,  only: [:index, :geo]
  skip_load_and_authorize_resource            only: [:index, :geo]
  skip_authorization_check                    only: [:index, :geo]

  # GET /perfiles
  # GET /perfiles.json
  def index
    @titulo = "Perfiles"
    @perfiles = PerfilDecorator.decorate(@perfiles)
    respond_to do |format|
      format.html do
        if request.xhr?   # solicitud ajax para la paginación
          render :index,  layout: false,
                          locals: { perfiles: @perfiles.pagina(params[:pagina]) }
        end
      end
      format.json { render  json: @perfiles,
                            only: [ :id,
                                    :numero,
                                    :nombre,
                                    :ubicacion,
                                    :fecha      ] }
    end
  end

  # GET /perfiles/geo.json
  def geo
    respond_to do |format|
      format.json { render json: como_geojson(
                    @perfiles.select { |c| c.ubicacion.try(:coordenadas?) },
                    :geometria)   }
    end
  end

  # Extendemos +ApplicationController#autocompletar+ y definimos el modelo sobre
  # el que consultar, controlando el input del usuario.
  #
  def autocompletar
    case params[:atributo]
      when 'numero'         then super(Perfil, :numero)
      when 'etiquetas'      then super(Perfil.tags(on: :etiquetas), :name)
      when 'reconocedores'  then super(Perfil.tags(on: :reconocedores), :name)
    end
  end

  # GET /perfiles/1
  # GET /perfiles/1.json
  def show
    @perfil = PerfilDecorator.new(@perfil)
    @titulo = "Perfil #{@perfil.numero}"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @perfil }
    end
  end

  # GET /perfiles/new
  # GET /perfiles/new.json
  def new
    @perfil = PerfilDecorator.new(@perfil)
    @titulo = 'Nuevo perfil'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @perfil }
    end
  end

  # GET /perfiles/1/edit
  def edit
    @perfil = PerfilDecorator.new(@perfil)
    @titulo = "Editando perfil #{@perfil.numero}"
  end

  # POST /perfiles
  # POST /perfiles.json
  def create
    @perfil.usuario = current_usuario

    respond_to do |format|
      if @perfil.save
        # Cada usuario es miembro de los perfiles que crea
        current_usuario.grant :miembro, @perfil
        format.html { redirect_to perfil_o_analisis,
                      notice: I18n.t('messages.created', model: 'Perfil') }
        format.json { render json: @perfil, status: :created, location: @perfil }
      else
        format.html { render action: "new" }
        format.json { render json: @perfil.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /perfiles/1
  # PUT /perfiles/1.json
  def update
    # Para poder eliminar subclases de capacidad mediante los checkboxes, tengo
    # que garantizar que haya un arreglo vacío. El formulario devuelve nil por
    # la especificación de html, asique lo corrijo.
    begin
      params[:perfil][:capacidad_attributes][:subclase_ids] ||= []
    rescue
      # Nada que hacer porque no hay capacidad asociada.
    end

    respond_to do |format|
      if @perfil.update_attributes(params[:perfil])
        format.html { redirect_to perfil_o_analisis,
                      notice: I18n.t('messages.updated', model: 'Perfil') }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @perfil.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perfiles/1
  # DELETE /perfiles/1.json
  def destroy
    @perfil.destroy

    respond_to do |format|
      format.html { redirect_to perfiles_url }
      format.json { head :ok }
    end
  end

  # Preparar los atributos a exportar/importar en CSV
  #
  def preparar_csv
    @atributos = Perfil.atributos_y_asociaciones :excepto =>
      [ :created_at, :updated_at, :adjuntos, :horizontes ]

    respond_to do |format|
      format.html
    end
  end

  def procesar_csv
    super(@perfiles, 'perfiles')
  end

  def seleccionar
    @continuar = session.delete :continuar
  end

  protected

    # Prepara el scope para la lista de perfiles
    def preparar
      # Selecciono sólo lo que necesito en el index
      @perfiles ||= Perfil.includes(:ubicacion, :serie)
        .select('fecha, modal, numero, perfiles.id, serie_id')
      @perfiles = @perfiles.search(params[:q]).result if params[:q].present?
    end

    # Ordena los resultados según las columnas de la lista. Si son columnas de
    # texto, las normaliza a lowercase.
    def ordenar
      case @metodo = metodo_de_ordenamiento
      when 'ubicacion'
        @perfiles =
          @perfiles.joins(:ubicacion)
                    .select('perfiles.*, ubicaciones.descripcion')
        @metodo = 'lower(ubicaciones.descripcion)'
      when 'nombre', 'numero'
        @metodo = "lower(#{@metodo})"
      else
        # A los date y boolean no se les aplica lower()
      end
      @perfiles = @perfiles.order("#{@metodo} #{direccion_de_ordenamiento}")
    end

    # Agrega la paginación al scope en curso
    def paginar
      @activo = %w[10 20 50].include?(params[:filas]) ? params[:filas] : '20'
      @perfiles = @perfiles.pagina(params[:pagina]).per(params[:filas])
    end

    # Determina la ruta a la que reenvia
    def perfil_o_analisis
      params[:analisis].present? ? edit_perfil_analisis_index_path(@perfil) : @perfil
    end

    # Revisa el input del usuario para los métodos de ordenamiento. Ordena según
    # la +fecha+ por default.
    def metodo_de_ordenamiento
      %w[ fecha nombre ubicacion numero modal
        ].include?(params[:por]) ? params[:por] : 'fecha'
    end

end
