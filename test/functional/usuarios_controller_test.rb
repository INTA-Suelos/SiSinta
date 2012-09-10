# encoding: utf-8
require './test/test_helper'

class UsuariosControllerTest < ActionController::TestCase

  test "debería loguear al usuario" do
    @simple = loguearse_como :invitado
    assert_equal @simple, @controller.current_usuario
  end

  test "current_user debería ser igual que current_usuario" do
    @simple = loguearse_como :invitado
    assert_not_nil @controller.current_usuario, "no hay un usuario logueado"
    assert_equal @controller.current_usuario, @controller.current_user, "devuelven diferentes cosas"
  end

  test "el usuario logueado debería ser admin" do
    @admin = loguearse_como :administrador
    assert @controller.current_usuario.admin?, "el usuario no es admin"
  end

end
