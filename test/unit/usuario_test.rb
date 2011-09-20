require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase

  fixtures :all

  test "preferencia de ficha del usuario" do
    simple = usuarios(:simple)
    completo = usuarios(:completo)
    nuevo = Usuario.new :ficha_simple => true
    assert_equal usuarios(:simple).ficha_simple, simple.usar_ficha_simple?
    assert_equal usuarios(:completo).ficha_simple, completo.usar_ficha_simple?
    assert nuevo.usar_ficha_simple?
  end

end
