# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  def usuario_activo
    Usuario.find(session[:id])
  end
end
