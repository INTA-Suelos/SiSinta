class InicioController < ApplicationController

  def index
    @usuarios = Usuario.all
  end

end
