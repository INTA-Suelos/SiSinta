require './test/test_helper'

describe Usuario do
  subject { create :usuario }

  describe 'validaciones' do
    it 'es válido' do
      _(subject).must_be :valid?
      _(build(:usuario)).must_be :valid?
    end

    it 'requiere nombre' do
      _(build(:usuario, nombre: nil)).wont_be :valid?
    end

    it 'tiene idioma por default' do
      _(build(:usuario).idioma).must_equal 'es'
    end

    it 'requiere idioma' do
      _(build(:usuario, idioma: nil)).wont_be :valid?
    end

    it 'idioma debe estar entre los disponibles del sistema' do
      I18n.available_locales.each do |locale|
        _(build(:usuario, idioma: locale)).must_be :valid?
      end

      _(build(:usuario, idioma: 'elfo')).wont_be :valid?
    end

    # TODO Revisar si es necesario validar sólo en update
    it 'requiere ficha al guardar' do
      subject.ficha = nil

      _(subject).wont_be :valid?
    end

    # TODO Revisar si es necesario validar sólo en update
    it 'requiere srid al guardar' do
      subject.srid = nil

      _(subject).wont_be :valid?
    end
  end

  it 'sabe qué ficha usa' do
    simple = create(:usuario, ficha: create(:ficha, identificador: 'especial'))

    _(simple.usa_ficha?('especial')).must_equal true, 'Debe poder especificar su propia ficha'
  end

  describe '#config' do
    it 'un usuario nuevo tiene config por defecto' do
      _(subject.config).must_be_kind_of Hash
      _(subject.srid).must_equal '4326'
    end
  end

  describe 'roles' do
    it 'sabe si es admin' do
      admin = create(:usuario, rol: 'Administrador')
      _(admin.roles).wont_be :blank?
      _(admin).must_be :admin?

      otro = create(:usuario)
      _(otro).wont_be :admin?
    end

    it 'sabe si es autorizado' do
      _(build(:usuario, rol: 'Autorizado')).must_be :autorizado?
    end

    it 'tiene o puede tener solo un rol global' do
      _(subject.rol_global).must_be :blank?

      subject.grant 'rey'
      _(subject.rol_global).must_equal 'rey'
      _(subject.has_role?('rey')).must_equal true

      subject.rol_global = 'plebeyo'
      _(subject.rol_global).must_equal 'plebeyo'
      _(subject.has_role?('plebeyo')).must_equal true
      _(subject.has_role?('rey')).wont_equal true
    end
  end
end
