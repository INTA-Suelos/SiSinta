# encoding: utf-8
require './test/test_helper'

class PermisosControllerTest < ActionController::TestCase
  test 'rutea a permisos (edit)' do
    assert_routing({
      path: '/permisos/perfil/345',
      method: :get
    },{
      controller: 'permisos', action: 'edit', modelo: 'perfil',
      id: '345'
    })
  end

  test 'rutea a permitir (update)' do
    assert_routing({
      path: '/permisos/perfil/345',
      method: :put
    },{
      controller: 'permisos', action: 'update', modelo: 'perfil',
      id: '345'
    })
  end

  test 'filtra los modelos habilitados para permisos' do
    usuario = loguearse_como 'Autorizado'

    %w{perfil proyecto serie}.each do |modelo|
      recurso = create(modelo, usuario: usuario)
      assert_equal recurso, @controller.send(:buscar_recurso_accesible, modelo, recurso.id)
    end

    assert_raise ActionController::RoutingError do
      @controller.send(:buscar_recurso_accesible, :usuario, usuario.id)
    end
  end
end
