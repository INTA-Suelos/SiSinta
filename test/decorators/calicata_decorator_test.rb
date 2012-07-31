# encoding: utf-8
require 'test_helper'

class CalicataDecoratorTest < ActiveSupport::TestCase

  fixtures :calicatas

  def setup
    ApplicationController.new.set_current_view_context
    @valida = calicatas(:valida)
  end

  test "decora la ubicación" do
    @valida.ubicacion = Ubicacion.new
    assert_kind_of Draper::Base, CalicataDecorator.decorate(@valida).ubicacion
  end

end
