# Prepara la página de inicio con el mapa de perfiles cargados
class InicioController < ApplicationController
  def index
    @perfiles = Perfil.count
    @publicos = Perfil.publicos.count
    @series = Serie.count
  end
end
