class FasesController < AutorizadoController

  # GET /fases
  # GET /fases.json
  def index
    @fases = Fase.all(:order => 'nombre ASC')

    respond_to do |format|
      format.html # index.html.{erb,haml}
      format.json { render  json: @fases }
    end
  end

  #
  # Extendemos +ApplicationController#ajax+ y definimos el modelo sobre el que
  # consultar.
  #
  def autocompletar
    super(Fase)
  end

end
