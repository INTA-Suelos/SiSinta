# encoding: utf-8
class ColoresController < ApplicationController

  # Extendemos +ApplicationController#autocompletar+ y definimos el modelo sobre
  # el que consultar, controlando el input del usuario.
  def autocompletar
    case params[:atributo]
      when 'hvc' then super(Color, :hvc)
      when 'rgb' then super(Color, :rgb)
    end
  end

end
