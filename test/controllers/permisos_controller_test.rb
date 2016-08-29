# encoding: utf-8
require './test/test_helper'

class PermisosControllerTest < ActionController::TestCase
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
