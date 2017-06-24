# cancancan necesita un método *current_user* y Devise genera la función en
# base al nombre del modelo, que en nuestro caso es Usuario. Lo definimos acá
# para que esté en todos los controladores
ActionController::Base.class_eval do 
  def current_user
    self.current_usuario
  end
end
