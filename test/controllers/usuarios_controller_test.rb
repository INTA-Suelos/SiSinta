# encoding: utf-8
require './test/test_helper'

class UsuariosControllerTest < ActionController::TestCase

  test "loguea al usuario" do
    @simple = loguearse_como "Invitado"
    assert_equal @simple, @controller.current_usuario
  end

  test "current_user y current_usuario son equivalentes" do
    @simple = loguearse_como "Invitado"
    assert_not_nil @controller.current_usuario, "no hay un usuario logueado"
    assert_equal @controller.current_usuario, @controller.current_user, "devuelven diferentes cosas"
  end

  test "el usuario logueado como 'Administrador' es admin" do
    @admin = loguearse_como 'Administrador'
    assert @controller.current_usuario.admin?, "el usuario no es admin"
  end

  test "autocompleta nombre" do
    loguearse_como 'Administrador'
    termino = create(:usuario).nombre

    get :autocomplete_usuario_nombre, term: termino
    assert_response :success
    assert_equal  Usuario.where("nombre like '%#{termino}%'").size,
                  json.size

    assert json.first.include?('id'), "debe devolver el id"
    assert json.first.include?('label'), "debe devolver el label"
    assert json.first.include?('value'), "debe devolver el nombre"
  end

  test "rutea a update_varios" do
    assert_routing({
      path: '/usuarios/update_varios',
      method: :put
    },{
      controller: 'usuarios', action: 'update_varios'
    })
  end
end
