# encoding: utf-8
class InicioController < ApplicationController

  def index
    @titulo = 'Sistema de información de Suelos del INTA'
    @subtitulo = 'Menú principal'
    @busqueda = Perfil.search
  end

end
