# -*- encoding : utf-8 -*-
require 'test_helper'

class SerieTest < ActiveSupport::TestCase

  setup do
    @serie = series(:carabela)
  end

  test "debería requerir el nombre" do
    assert Serie.new(series(:anonima).attributes).invalid?, "valida sin nombre"
  end

  test "no debería permitir nombres duplicados" do
    Serie.create(series(:carabela).attributes)
    assert Serie.new(series(:carabela).attributes).invalid?, "permite nombres duplicados"
  end

end
