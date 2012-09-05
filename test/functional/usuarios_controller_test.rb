# encoding: utf-8
require './test/test_helper'

class UsuariosControllerTest < ActionController::TestCase

  setup do
    @simple = create(:usuario)
    @admin = create(:usuario, :admin)
  end

  test "debería loguear al usuario" do
    sign_in @simple
    assert_equal @simple, @controller.current_usuario
  end

  test "current_user debería ser igual que current_usuario" do
    sign_in @simple
    assert_not_nil @controller.current_usuario, "no hay un usuario logueado"
    assert_equal @controller.current_usuario, @controller.current_user, "devuelven diferentes cosas"
  end

  test "el usuario logueado debería ser admin" do
    sign_in @admin
    assert @controller.current_usuario.admin?, "el usuario no es admin"
  end

end
