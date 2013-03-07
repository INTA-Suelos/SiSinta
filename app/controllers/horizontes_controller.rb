# encoding: utf-8
class HorizontesController < AutorizadoController

  before_filter :cargar_horizontes
  skip_before_filter :authenticate_usuario!, :only => [:index, :geo]

  # GET /horizontes
  # GET /horizontess.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render  json: @horizontes }
    end
  end

  # Preparar los atributos a exportar/importar en CSV
  def exportar
    @atributos = Horizonte.atributos_y_asociaciones :excepto =>
      [ :created_at, :updated_at, :analitico ]

    respond_to do |format|
      format.html
    end
  end

  def procesar_csv
    super(@horizontes, 'horizontes')
  end

  protected

    def cargar_horizontes
      @horizontes = Horizonte.order('perfil_id ASC')
    end

end
