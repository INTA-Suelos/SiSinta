# -*- encoding : utf-8 -*-
require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase

  fixtures :all

  test "debería tener en cuenta preferencias de ficha del usuario" do
    simple = usuarios(:simple)
    completo = usuarios(:completo)
    assert_equal usuarios(:simple).ficha_simple, simple.usa_ficha_simple?, 'el método ? no devuelve el valor correcto de la variable'
    assert_equal usuarios(:completo).ficha_simple, completo.usa_ficha_simple?, 'el método ? no devuelve el valor correcto de la variable'
    nuevo = Usuario.new
    assert !nuevo.usa_ficha_simple?, 'el valor por omisión debería ser la ficha completa'
    nuevo = Usuario.new ficha_simple: true
    assert nuevo.usa_ficha_simple?, 'no se puede pasar la preferencia en la creación'
  end

end
