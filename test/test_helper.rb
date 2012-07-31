# encoding: utf-8
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  # Helpers para los controladores
  include Devise::TestHelpers
end
