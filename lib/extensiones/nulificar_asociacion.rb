# encoding: utf-8
# Atributos virtuales para usar con el FormBuilder, para nulificar una
# asociación en vez de destruirla con _destroy
# TODO gemificar esta extensión junto con el helper
module NulificarAsociacion
  extend ActiveSupport::Concern

  included do
    def anular
      false
    end

    def anular=(asociacion)
      self.send("#{asociacion}=", nil)
    end
  end
end

# Autoinclusión de la extensión
ActiveRecord::Base.send(:include, NulificarAsociacion)
