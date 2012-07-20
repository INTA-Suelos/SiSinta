# -*- encoding : utf-8 -*-
require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase

  setup do
    @admin = Usuario.find_by_nombre('Administrador')
    @simple = Usuario.create( nombre: 'simplón',
                              email: 'roro@usuarios.com',
                              config: { ficha: 'simple', srid: '4326' },
                              password: 's1mpl3c1t0' )
    @completo = Usuario.create nombre: 'completín', email: 'dada@usuarios.com'
  end

  test "debería tener en cuenta preferencias de ficha del usuario" do
    assert @simple.usa_ficha?('simple'), 'El método ? no devuelve el valor correcto de la variable'
    assert !@completo.usa_ficha?('simple'), 'El método ? no devuelve el valor correcto de la variable'
    @nuevo = Usuario.new config: { ficha: 'simple' }
    assert @nuevo.usa_ficha?('simple'), 'No se puede pasar la preferencia en la creación'
  end

  test "debería crear un nuevo rol" do
    assert_difference 'Rol.count' do
      @simple.roles << Rol.new(:nombre => 'mendocino')
      @simple.save
    end
  end

  test "debería responder correctamente sobre si es admin" do
    assert !@admin.roles.blank?, "No carga los roles de la DB"
    assert @admin.admin?, "Debería ser admin"
    assert !@simple.admin?, "No debería ser admin"
  end

  test "debería crear correctamente al usuario" do
    assert_nothing_raised do
      @u = Usuario.new(  :nombre => 'Otro Administrador',
                         :email => 'email@falso2.com',
                         :password => 'administrador')
      assert @u.save, "No guarda al usuario"
      @u.roles.clear << Rol.find_by_nombre('administrador')
      assert_equal @u.roles.first, Rol.find_by_nombre('administrador'), "No guarda la relación"
    end
  end

  test "debería crear el usuario con un rol por default" do
    assert_includes @simple.roles, Rol.find_by_nombre('invitado'), "Debería tener el Rol 'invitado' al principio"
  end

  test "debería comprobar el rol" do
    assert @admin.es?('administrador'), ".es? falla con string"
    assert @admin.es?(Rol.administrador), ".es? falla con Rol"
    assert @admin.es?(:administrador), ".es? falla con symbol"
    assert @admin.admin?, "Un admin no es administrador"
    assert @simple.es? 'invitado'
    assert @simple.es? Rol.invitado
    assert @simple.invitado?, "Un usuario nuevo no es invitado"
  end

  test "un usuario nuevo debería tener config por defecto" do
    assert_instance_of Hash, Usuario.new.config
    assert_equal 'completa',  Usuario.new.ficha
    assert_equal '4326',      Usuario.new.srid
  end

end
