# -*- encoding : utf-8 -*-
require 'test_helper'

class SerieTest < ActiveSupport::TestCase

  setup do
    @serie = series(:carabela)
  end

  test "debería requerir el nombre" do
    assert Serie.new(series(:anonima)).invalid?, "valida sin nombre"
  end

  test "no debería permitir nombres duplicados" do
    Serie.create(@serie)
    assert Serie.new(@serie.attributes).invalid?, "permite nombres duplicados"
  end

end
