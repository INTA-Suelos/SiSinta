# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  # CanCan necesita un método *current_user* y Devise genera la función
  # en base al nombre del modelo, que en nuestro caso es Usuario
  def current_user
    current_usuario
  end

  # Métodos de BrowserDetect
  helper_method :browser_is?, :browser_webkit_version, :ua, :browser_is_mobile?
end
