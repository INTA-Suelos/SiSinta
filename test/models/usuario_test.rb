# encoding: utf-8
require './test/test_helper'

class UsuarioTest < ActiveSupport::TestCase
  test "tiene en cuenta las preferencias de ficha del usuario" do
    default = create(:usuario)
    simple = create(:usuario, config: { ficha: 'especial', srid: '4326' })

    assert default.usa_ficha?('completa'), 'Debe usar la ficha completa por default'
    assert simple.usa_ficha?('especial'), 'Debe poder especificar su propia ficha'
  end

  test "detecta administradores" do
    admin = create(:usuario, rol: 'Administrador')
    refute admin.roles.blank?, "No carga los roles de la DB"
    assert admin.admin?, "Debería ser admin"

    otro = create(:usuario)
    refute otro.admin?, "No debería ser admin"
  end

  test "comprueba el rol" do
    assert build(:usuario, rol: 'Administrador').admin?, "Debe ser admin"
    assert build(:usuario, rol: 'Autorizado').autorizado?, "Debe ser autorizado"
  end

  test "un usuario nuevo tiene config por defecto" do
    usuario = create(:usuario)
    assert_kind_of Hash, usuario.config
    assert_equal 'completa', usuario.ficha
    assert_equal '4326', usuario.srid
  end

  test "tiene o puede tener solo un rol global" do
    usuario = create(:usuario)
    assert usuario.rol_global.blank?

    usuario.grant 'rey'
    assert_equal 'rey', usuario.rol_global
    assert usuario.has_role? 'rey'

    usuario.rol_global = 'plebeyo'
    assert_equal 'plebeyo', usuario.rol_global
    assert usuario.has_role? 'plebeyo'
    refute usuario.has_role? 'rey'
  end
end
