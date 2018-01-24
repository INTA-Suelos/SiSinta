# Tests para las rutas custom de adjuntos
require 'test_helper'

describe 'Adjuntos Route Integration Test' do
  it 'rutea a index' do
    value({
      controller: 'adjuntos', action: 'index', perfil_id: '1'
    }).must_route_for({
      path: '/perfiles/1/adjuntos', method: :get
    })
  end

  it 'rutea a show' do
    value({
      controller: 'adjuntos', action: 'show',
      perfil_id: '1', id: '2'
    }).must_route_for({
      path: '/perfiles/1/adjuntos/2',
      method: :get
    })
  end

  it 'rutea a descargar' do
    value({
      controller: 'adjuntos', action: 'descargar',
      perfil_id: '1', id: '2'
    }).must_route_for({
      path: '/perfiles/1/adjuntos/2/descargar',
      method: :get
    })
  end
end
