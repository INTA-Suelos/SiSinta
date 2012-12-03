# encoding : utf-8
require './test/test_helper'

class AbilityTest < ActiveSupport::TestCase

  setup do
    @admin = build(:usuario, rol: I18n.t('roles.admin'))
    @autorizado = build(:usuario, rol: I18n.t('roles.data_entry'))
    @invitado = build(:usuario, rol: "Invitado")
    @recursos = [Perfil, Horizonte, Grupo, Fase, Analisis, Adjunto, Usuario]
  end

  test "deberia permitirle todo al administrador" do
    assert @admin.admin?, "No es administrador"

    @permisos = Ability.new @admin

    @recursos.each do |recurso|
      assert @permisos.can?(:manage, recurso.new), "No puede administrar #{recurso}"
    end
  end

  test "debería permitirle administrar objetos basicos a los autorizados" do
    refute @autorizado.admin?, "Es administrador"
    assert @autorizado.has_role?(I18n.t('roles.data_entry')), "No es autorizado"

    @permisos = Ability.new @autorizado

    (@permisos.basicos + @permisos.perfiles).each do |recurso|
      assert @permisos.can?(:manage, recurso.new), "No puede administrar #{recurso}"
    end
    assert @permisos.cannot?(:manage, Usuario.new), "Puede administrar Usuario"
  end

  test "debería prohibirle a los invitados crear o modificar objetos" do
    refute @invitado.admin?, "Es administrador"
    refute @invitado.has_role?(I18n.t('roles.data_entry')), "Es autorizado"
    assert @invitado.has_role?("Invitado"), "No es invitado"

    @permisos = Ability.new @invitado

    @recursos.each do |recurso|
      [:create, :update, :destroy].each do |realizar_accion|
        assert @permisos.cannot?(realizar_accion, recurso), "Puede #{realizar_accion} sobre #{recurso}"
      end
    end
  end

end
