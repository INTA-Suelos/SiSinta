# encoding: utf-8
require './test/test_helper'

class ApplicationDecoratorTest < ActiveSupport::TestCase

  def setup
    ApplicationController.new.view_context
  end

  test "debería convertir el modelo a Array" do
    assert_instance_of Array, PerfilDecorator.decorate(build(:perfil)).to_array, "no devuelve Array"
  end

end
