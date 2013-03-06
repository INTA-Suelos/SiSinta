# encoding: utf-8
require './test/test_helper'

class UsuarioTest < ActiveSupport::TestCase

  setup do
    @admin = create(:usuario, rol: :admin)
    @simple = create(:usuario, rol: "Invitado", config: { ficha: 'simple', srid: '4326' })
    @completo = create(:usuario, rol: "Autorizado")
  end

  test "debería tener en cuenta preferencias de ficha del usuario" do
    assert @simple.usa_ficha?('simple'), 'El método ? no devuelve el valor correcto de la variable'
    assert !@completo.usa_ficha?('simple'), 'El método ? no devuelve el valor correcto de la variable'
    @nuevo = Usuario.new config: { ficha: 'simple' }
    assert @nuevo.usa_ficha?('simple'), 'No se puede pasar la preferencia en la creación'
  end

  test "debería responder correctamente sobre si es admin" do
    assert !@admin.roles.blank?, "No carga los roles de la DB"
    assert @admin.admin?, "Debería ser admin"
    assert !@simple.admin?, "No debería ser admin"
  end

  test "debería crear correctamente al usuario" do
    assert_nothing_raised do
      @u = build(:usuario)
      assert @u.save, "No guarda al usuario"
      @u.grant :admin
      assert @u.has_role?(:admin), "No guarda el rol"
    end
  end

  test "debería comprobar el rol" do
    assert @admin.admin?, "Un admin no es administrador"
  end

  test "un usuario nuevo debería tener config por defecto" do
    usuario = create(:usuario)
    assert_instance_of Hash, usuario.config
    assert_equal 'completa', usuario.ficha
    assert_equal '4326', usuario.srid
  end

end
