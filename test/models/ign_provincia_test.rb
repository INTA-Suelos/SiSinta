require './test/test_helper'

class IgnProvinciaTest < ActiveSupport::TestCase
  it 'devuelve la columna donde están los polígonos' do
    IgnProvincia.respond_to?(:poligonos).must_equal true
  end
end
