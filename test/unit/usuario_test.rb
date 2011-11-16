# -*- encoding : utf-8 -*-
require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase

  fixtures :all

  setup do
    @admin = Usuario.find_by_nombre('Administrador')
    @simple = Usuario.create  :nombre => 'simplón',
                              :email => 'roro@usuarios.com',
                              :ficha => 'simple',
                              :password => 's1mpl3c1t0'
    @completo = Usuario.create :nombre => 'completín', :email => 'dada@usuarios.com'
  end

  test "debería tener en cuenta preferencias de ficha del usuario" do
    assert @simple.usa_ficha_simple?, 'el método ? no devuelve el valor correcto de la variable'
    assert !@completo.usa_ficha_simple?, 'el método ? no devuelve el valor correcto de la variable'
    @nuevo = Usuario.new
    assert !@nuevo.usa_ficha_simple?, 'el valor por omisión debería ser la ficha completa'
    @nuevo = Usuario.new ficha: 'simple'
    assert @nuevo.usa_ficha_simple?, 'no se puede pasar la preferencia en la creación'
  end

  test "debería crear un nuevo rol" do
    assert_nothing_raised do
      assert_blank @simple.roles, "no debería tener roles al principio"
      assert_difference 'Rol.count' do
        @simple.roles << Rol.new(:nombre => 'mendocino')
        @simple.save
      end
    end
  end

  test "debería responder correctamente sobre si es admin" do
    assert !@admin.roles.blank?, "no carga los roles de la DB"
    assert @admin.admin?, "debería ser admin"
    assert !@simple.admin?, "no debería ser admin"
  end

  test "debería crear correctamente al usuario" do
    assert_nothing_raised do
      @u = Usuario.new(  :nombre => 'Otro Administrador',
                         :email => 'email@falso2.com',
                         :password => 'administrador')
      assert @u.save, "no guarda al usuario"
      @u.roles << Rol.find_by_nombre('administrador')
      assert_equal @u.roles.first, Rol.find_by_nombre('administrador'), "no guarda la relación"
    end
  end

end
