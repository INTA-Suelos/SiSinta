# encoding: utf-8
require './test/test_helper'

class ApplicationDecoratorTest < Draper::TestCase
  test "convierte el modelo a Array" do
    assert_instance_of Array, PerfilDecorator.decorate(build(:perfil)).to_array, "no devuelve Array"
  end
end
