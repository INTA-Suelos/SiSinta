# encoding: utf-8
class InicioController < ApplicationController
  def index
    @busqueda = Perfil.search
  end
end
