# encoding: utf-8
require './test/test_helper'

class UsuariosControllerTest < ActionController::TestCase

  test "debería loguear al usuario" do
    @simple = loguearse_como "Invitado"
    assert_equal @simple, @controller.current_usuario
  end

  test "current_user debería ser igual que current_usuario" do
    @simple = loguearse_como "Invitado"
    assert_not_nil @controller.current_usuario, "no hay un usuario logueado"
    assert_equal @controller.current_usuario, @controller.current_user, "devuelven diferentes cosas"
  end

  test "el usuario logueado debería ser admin" do
    @admin = loguearse_como :admin
    assert @controller.current_usuario.admin?, "el usuario no es admin"
  end

  test "devuelve nombre para términos parciales" do
    loguearse_como :admin
    @termino = create(:usuario).nombre
    get :autocomplete_usuario_nombre, term: @termino
    assert_response :success
    assert_equal  Usuario.where("nombre like '%#{@termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('value'), "debe devolver el nombre"
  end

end
