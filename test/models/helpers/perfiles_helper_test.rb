# encoding: utf-8
require './test/test_helper'
require 'perfiles_helper'

class PerfilesHelperTest < ActionView::TestCase
  setup do
    # Para poder stubear params
    @helper = Struct.new(:params).new
    @helper.send :extend, PerfilesHelper
  end

  test "usa el método de selección por omisión" do
    @helper.stub :params, { } do
      assert_equal :put, @helper.metodo_de_seleccion
    end
  end

  test "permite definir el método de selección" do
    @helper.stub :params, { metodo: 'post' } do
      assert_equal 'post', @helper.metodo_de_seleccion
    end
  end
end
