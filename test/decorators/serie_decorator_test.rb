require 'test_helper'

class SerieDecoratorTest < ActiveSupport::TestCase
  def setup
    ApplicationController.new.view_context
  end
end
