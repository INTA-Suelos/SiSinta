# encoding: utf-8
require './test/test_helper'

class CalicataDecoratorTest < ActiveSupport::TestCase

  def setup
    ApplicationController.new.set_current_view_context
    @calicata = build_stubbed(:calicata)
  end

  test "decora la ubicación" do
    @calicata.ubicacion = Ubicacion.new
    assert_kind_of Draper::Base, CalicataDecorator.decorate(@calicata).ubicacion
  end

end
