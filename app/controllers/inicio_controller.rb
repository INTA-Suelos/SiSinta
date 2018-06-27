# Prepares the landing page with a profile map
class InicioController < ApplicationController
  def index
    @perfiles = Perfil.count
    @publicos = Perfil.publicos.count
    @series = Serie.count

    # These values could be dynamically configured
    @map = {
      center: Rails.application.config.center,
      zoom: Rails.application.config.zoom
    }
  end
end
