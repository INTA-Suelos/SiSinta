# encoding : utf-8
require './test/test_helper'

class AbilityTest < ActiveSupport::TestCase

  setup do
    @admin = build(:usuario, rol: :admin)
    @autorizado = build(:usuario, rol: :autorizado)
    @invitado = build(:usuario, rol: :invitado)
    @recursos = [Perfil, Horizonte, Grupo, Fase, Analitico, Adjunto, Usuario]
  end

  test "deberia permitirle todo al administrador" do
    assert @admin.admin?, "No es administrador"

    permisos = Ability.new @admin

    @recursos.each do |recurso|
      assert permisos.can?(:manage, recurso.new), "No puede administrar #{recurso}"
    end
  end

  test "debería permitirle administrar objetos basicos a los autorizados" do
    assert @autorizado.has_role?(:autorizado), "No es autorizado"
    assert_equal 1, @autorizado.roles.size, "Tiene más de 1 rol"

    permisos = Ability.new @autorizado

    (permisos.basicos + permisos.perfiles).each do |recurso|
      assert permisos.can?(:manage, recurso.new), "No puede administrar #{recurso}"
    end
    assert permisos.cannot?(:manage, Usuario.new), "Puede administrar Usuario"
  end

  test "debería prohibirle a los invitados crear o modificar objetos" do
    assert @invitado.has_role?(:invitado), "No es invitado"
    assert_equal 1, @invitado.roles.size, "Tiene más de 1 rol"

    permisos = Ability.new @invitado

    @recursos.each do |recurso|
      [:create, :update, :destroy].each do |realizar_accion|
        assert permisos.cannot?(realizar_accion, recurso), "Puede #{realizar_accion} sobre #{recurso}"
      end
    end
  end

  test "debería permitirle a los miembros modificar un objeto" do
    miembro = create(:usuario)
    perfil = create(:perfil)
    miembro.add_role :miembro, perfil
    permisos = Ability.new miembro
    assert permisos.can?(:modificar, perfil),
      "No puede administrar un perfil del que es miembro"
    refute permisos.can?(:modificar, create(:perfil)),
      "Puede administrar un perfil del que no es miembro"
  end

end
