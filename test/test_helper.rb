# encoding: utf-8
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/mock'
require 'minitest/rails'
require 'minitest/rails/capybara'

DatabaseCleaner.clean_with :truncation

# Helpers para los unit tests
class ActiveSupport::TestCase
  # Para llamar a los métodos core de FactoryGirl directamente (build,
  # build_stubbed, create, attributes_for, y los *_list)
  include FactoryGirl::Syntax::Methods
end

# Helpers para los controladores
class ActionController::TestCase
  include Devise::TestHelpers

  setup { DatabaseCleaner.start }
  teardown { DatabaseCleaner.clean }

  def loguearse
    loguearse_como 'Cualquiera'
  end

  # FIXME Con `autorizar` no debería hacer falta especificar un tipo de usuario
  def loguearse_como(tipo_de_usuario)
    @usuario = create :usuario, rol: tipo_de_usuario
    @request.env['devise.mapping'] = Devise.mappings[:usuario]
    sign_in @usuario
    return @usuario
  end

  # FIXME rediseñar los tests usando esto
  def autorizar
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @ability.can :manage, :all
    @controller.stub(:current_ability, @ability) do
      yield
    end
  end

  def json
    ActiveSupport::JSON.decode @response.body
  end
end

# Tests de integración
class Capybara::Rails::TestCase
  include ApplicationHelper
  include Warden::Test::Helpers # login_as

  # No podemos usar transacciones con selenium
  DatabaseCleaner.strategy = :truncation
  self.use_transactional_fixtures = false

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
    # Limpiar los hooks de warden para todos los request (ver +loguearse_como+)
    Warden::Manager._on_request.clear
    Warden.test_reset!
  end

  def loguearse_como(tipo_de_usuario)
    loguear create(:usuario, rol: tipo_de_usuario)
  end

  def loguear(usuario)
    # Este debería ser el default de Warden
    Warden::Manager.on_request do |proxy|
      proxy.set_user usuario, scope: :usuario
    end

    usuario
  end
end

# Registrando el driver podemos pasar opciones como el profile a usar
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new app, browser: :firefox, profile: 'selenium'
end
