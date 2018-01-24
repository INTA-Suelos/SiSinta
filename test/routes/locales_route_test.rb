# Tests para las rutas con locales
require 'test_helper'

describe 'Locales Route Integration Test' do
  describe 'root' do
    it 'rutea sin :locale' do
      value({
        controller: 'inicio', action: 'index'
      }).must_route_for({
        path: '/', method: :get
      })
    end

    it 'rutea con :locale' do
      value({
        controller: 'inicio', action: 'index', locale: 'en'
      }).must_route_for({
        path: '/en', method: :get
      })
    end
  end

  describe 'cualquier controller' do
    it 'rutea sin locale' do
      value({
        controller: 'perfiles', action: 'show', id: '345'
      }).must_route_for({
        path: '/perfiles/345', method: :get
      })
    end

    it 'rutea con locale' do
      value({
        controller: 'perfiles', action: 'show', id: '345', locale: 'en'
      }).must_route_for({
        path: '/en/perfiles/345', method: :get
      })
    end
  end
end
