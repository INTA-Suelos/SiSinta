require './test/test_helper'

describe 'Usuarios Route Integration Test' do
  it 'rutea a update_varios' do
    value({
      controller: 'usuarios', action: 'update_varios'
    }).must_route_for({
      path: '/usuarios/update_varios',
      method: :put
    })
  end
end
