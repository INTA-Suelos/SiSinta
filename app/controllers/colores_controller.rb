class ColoresController < ApplicationController

  # Extendemos +ApplicationController#autocompletar+ y definimos el modelo sobre
  # el que hacemos la consulta.
  def autocompletar
    super(Color)
  end

end
