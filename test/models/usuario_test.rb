require './test/test_helper'

describe Usuario do
  subject { create :usuario }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
      build(:usuario).must_be :valid?
    end

    it 'requiere nombre' do
      build(:usuario, nombre: nil).wont_be :valid?
    end

    it 'tiene idioma por default' do
      build(:usuario).idioma.must_equal 'es'
    end

    it 'requiere idioma' do
      build(:usuario, idioma: nil).wont_be :valid?
    end

    # TODO Revisar si es necesario validar sólo en update
    it 'requiere ficha al guardar' do
      subject.ficha = nil

      subject.wont_be :valid?
    end

    # TODO Revisar si es necesario validar sólo en update
    it 'requiere srid al guardar' do
      subject.srid = nil

      subject.wont_be :valid?
    end
  end

  it 'sabe qué ficha usa' do
    simple = create(:usuario, ficha: create(:ficha, identificador: 'especial'))

    simple.usa_ficha?('especial').must_equal true, 'Debe poder especificar su propia ficha'
  end

  describe '#config' do
    it 'un usuario nuevo tiene config por defecto' do
      subject.config.must_be_kind_of Hash
      subject.srid.must_equal '4326'
    end
  end

  describe 'roles' do
    it 'sabe si es admin' do
      admin = create(:usuario, rol: 'Administrador')
      admin.roles.wont_be :blank?
      admin.must_be :admin?

      otro = create(:usuario)
      otro.wont_be :admin?
    end

    it 'sabe si es autorizado' do
      build(:usuario, rol: 'Autorizado').must_be :autorizado?
    end

    it 'tiene o puede tener solo un rol global' do
      subject.rol_global.must_be :blank?

      subject.grant 'rey'
      subject.rol_global.must_equal 'rey'
      subject.has_role?('rey').must_equal true

      subject.rol_global = 'plebeyo'
      subject.rol_global.must_equal 'plebeyo'
      subject.has_role?('plebeyo').must_equal true
      subject.has_role?('rey').wont_equal true
    end
  end
end
