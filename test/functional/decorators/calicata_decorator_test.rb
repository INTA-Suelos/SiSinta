# encoding: utf-8
require './test/test_helper'

class CalicataDecoratorTest < ActiveSupport::TestCase

  def setup
    @calicata = build_stubbed(:calicata)
  end

  test "decora la ubicación" do
    @calicata.ubicacion = create(:ubicacion)
    assert_kind_of Draper::Base, CalicataDecorator.decorate(@calicata).ubicacion
  end

  test "usa día/mes/año para la fecha" do
    @calicata.fecha = Date.new
    assert_equal Date.new.to_s(:dma), CalicataDecorator.decorate(@calicata).fecha
  end

end
