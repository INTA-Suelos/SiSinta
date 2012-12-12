# encoding: utf-8
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# Helpers para los unit tests
class ActiveSupport::TestCase
  # Para llamar a los métodos core de FactoryGirl directamente (build,
  # build_stubbed, create, attributes_for, y los *_list)
  include FactoryGirl::Syntax::Methods
end

# Helpers para los controladores
class ActionController::TestCase
  include Devise::TestHelpers

  def loguearse_como(tipo_de_usuario)
    @usuario = create :usuario, rol: tipo_de_usuario
    @request.env["devise.mapping"] = Devise.mappings[:usuario]
    sign_in @usuario
    return @usuario
  end

  def json
    ActiveSupport::JSON.decode @response.body
  end
end
