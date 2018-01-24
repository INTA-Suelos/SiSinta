# Tests para las rutas custom de permisos
require 'test_helper'

describe 'Permisos Route Integration Test' do
  it 'rutea a permisos (edit)' do
    value({
      controller: 'permisos', action: 'edit', modelo: 'perfil',
      id: '345'
    }).must_route_for({
      path: '/permisos/perfil/345',
      method: :get
    })
  end

  it 'rutea a permitir (update)' do
    value({
      controller: 'permisos', action: 'update', modelo: 'perfil',
      id: '345'
    }).must_route_for({
      path: '/permisos/perfil/345',
      method: :put
    })
  end
end
