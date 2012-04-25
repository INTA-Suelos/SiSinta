class GruposController < AutorizadoController

  # GET /grupos
  # GET /grupos.json
  def index
    @grupos = Grupo.all(:order => 'descripcion ASC')

    respond_to do |format|
      format.html # index.html.{erb,haml}
      format.json { render  json: @grupos }
    end
  end

  #
  # Extendemos +ApplicationController#ajax+ y definimos el modelo sobre el que
  # consultar.
  #
  def autocompletar
    super(Grupo)
  end

end
