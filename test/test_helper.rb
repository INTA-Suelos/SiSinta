# encoding: utf-8
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require "minitest/rails"
require 'minitest/mock'

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

# Transactional fixtures do not work with Selenium tests, because Capybara
# uses a separate server thread, which the transactions would be hidden
# from. We hence use DatabaseCleaner to truncate our test database.
DatabaseCleaner.strategy = :truncation

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  include FactoryGirl::Syntax::Methods

  # Stop ActiveRecord from wrapping tests in transactions
  self.use_transactional_fixtures = false

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end

  def loguearse_como(tipo_de_usuario)
    @usuario = create :usuario, rol: tipo_de_usuario
    visit new_usuario_session_path
    within 'form' do
      fill_in Usuario.human_attribute_name('email'),    with: @usuario.email
      fill_in Usuario.human_attribute_name('password'), with: @usuario.password
      click_button 'Entrar'
    end
    return @usuario
  end

  # Datos requeridos para submitear un perfil
  def completar_datos_de_perfil_requeridos
    fill_in Perfil.human_attribute_name('fecha'),    with: '23/3/1987'
  end
end
