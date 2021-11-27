require 'test_helper'

describe PermisosController do
  let(:usuario) { loguearse_como 'Autorizado' }

  it 'filtra los modelos habilitados para permisos' do
    %w{perfil proyecto serie}.each do |modelo|
      recurso = create(modelo, usuario: usuario)

      _(@controller.send(:buscar_recurso_accesible, modelo, recurso.id)).must_equal recurso
    end

    assert_raise ActionController::RoutingError do
      @controller.send(:buscar_recurso_accesible, :usuario, usuario.id)
    end
  end
end
