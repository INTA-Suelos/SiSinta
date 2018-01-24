# Tests para las rutas custom de perfiles
require 'test_helper'

describe 'Perfiles Route Integration Test' do
  it 'rutea a editar_analiticos' do
    value({
      controller: 'perfiles', action: 'editar_analiticos',
      id: '345'
    }).must_route_for({
      path: '/perfiles/345/editar_analiticos',
      method: :get
    })
  end

  it 'rutea a update_analiticos' do
    value({
      controller: 'perfiles', action: 'update_analiticos',
      id: '123'
    }).must_route_for({
      path: '/perfiles/123/update_analiticos',
      method: :put
    })
  end

  it 'rutea a exportar' do
    value({
      controller: 'perfiles', action: 'exportar'
    }).must_route_for({
      path: '/perfiles/exportar',
      method: :get
    })
  end

  it 'rutea a procesar' do
    value({
      controller: 'perfiles', action: 'procesar'
    }).must_route_for({
      path: '/perfiles/procesar',
      method: :post
    })
  end

  it 'rutea a almacenar' do
    value({
      controller: 'perfiles', action: 'almacenar'
    }).must_route_for({
      path: '/perfiles/almacenar',
      method: :put
    })
  end

  it 'rutea a seleccionar_perfiles' do
    value({
      controller: 'perfiles', action: 'seleccionar'
    }).must_route_for({
      path: '/perfiles/seleccionar',
      method: :get
    })
  end
end
