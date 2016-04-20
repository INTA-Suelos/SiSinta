require './test/test_helper'

describe Usuario do
  it 'sabe qué ficha usa' do
    simple = create(:usuario, ficha: create(:ficha, identificador: 'especial'))

    simple.usa_ficha?('especial').must_equal true, 'Debe poder especificar su propia ficha'
  end

  describe '#config' do
    it 'un usuario nuevo tiene config por defecto' do
      usuario = create(:usuario)
      assert_kind_of Hash, usuario.config
      assert_equal '4326', usuario.srid
    end
  end

  describe 'roles' do
    it 'sabe si es admin' do
      admin = create(:usuario, rol: 'Administrador')
      refute admin.roles.blank?, 'No carga los roles de la DB'
      assert admin.admin?, 'Debería ser admin'

      otro = create(:usuario)
      refute otro.admin?, 'No debería ser admin'
    end

    it 'sabe si es autorizado' do
      assert build(:usuario, rol: 'Autorizado').autorizado?, 'Debe ser autorizado'
    end

    it 'tiene o puede tener solo un rol global' do
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
end
