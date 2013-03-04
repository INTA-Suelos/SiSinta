# encoding : utf-8
require './test/test_helper'

class AbilityTest < ActiveSupport::TestCase

  test "los administradores pueden tocar todo" do
    admin = create(:usuario, rol: :admin)
    permisos = Ability.new admin

    permisos.recursos.each do |recurso|
      assert permisos.can?(:manage, recurso), "Debe poder administrar #{recurso}"
    end
    assert permisos.can?(:manage, Usuario), "Debe poder administrar Usuario"
  end

  test "los usuarios autorizados pueden ver cualquier objeto" do
    autorizado = create(:usuario, rol: :autorizado)
    permisos = Ability.new autorizado

    perfil_ajeno = build_stubbed(:perfil, usuario: create(:usuario))

    assert permisos.can?(:read, perfil_ajeno), "Debe poder ver un perfil ajeno"
    assert permisos.cannot(:update, perfil_ajeno), "No debe poder cambiar un perfil ajeno"
    assert permisos.cannot(:destroy, perfil_ajeno), "No debe poder destruir un perfil ajeno"
    assert permisos.cannot(:manage, perfil_ajeno), "No debe poder administrar un perfil ajeno"
    assert permisos.cannot(:modificar, perfil_ajeno), "No debe poder modificar un perfil ajeno"
  end

  test "los usuarios autorizados pueden crear objetos propios" do
    autorizado = create(:usuario, rol: :autorizado)
    permisos = Ability.new autorizado

    permisos.recursos.each do |recurso|
      assert permisos.can?(:create, recurso), "Debe poder crear #{recurso}"
    end
  end

  test "los usuarios autorizados pueden manejar sus propios objetos" do
    autorizado = create(:usuario, rol: :autorizado)
    permisos = Ability.new autorizado
    perfil = build_stubbed(:perfil, usuario: autorizado)

    assert permisos.can?(:manage, perfil), "Debe poder administrar sus recursos"
  end

  test "los miembros de algo pueden administrarlo" do
    miembro = create(:usuario)
    perfil = create(:perfil)
    miembro.grant :miembro, perfil
    permisos = Ability.new miembro

    assert permisos.can?(:modificar, perfil),
      "No puede administrar un perfil del que es miembro"
    refute permisos.can?(:modificar, create(:perfil)),
      "Puede administrar un perfil del que no es miembro"
  end

  test "los invitados no pueden crear o modificar recursos" do
    invitado = create(:usuario)
    permisos = Ability.new invitado

    permisos.recursos.each do |recurso|
      [:create, :update, :destroy].each do |accionar|
        assert permisos.cannot?(accionar, recurso), "No debe poder #{accionar} sobre #{recurso}"
      end
    end
  end

  test "los invitados sólo pueden leer recursos que son públicos" do
    invitado = create(:usuario)
    permisos = Ability.new invitado
    perfil_privado = build_stubbed(:perfil)
    perfil_publico = build_stubbed(:perfil, publico: true)

    assert permisos.cannot?(:read, perfil_privado), "No debe poder ver recursos privados"
    assert permisos.can?(:read, perfil_publico), "Debe poder ver recursos públicos"
  end

  test "los invitados pueden leer recursos básicos" do
    invitado = create(:usuario)
    permisos = Ability.new invitado

    permisos.recursos.each do |recurso|
      assert permisos.can?(:read, recurso), "Debe poder leer recursos básicos"
    end
  end
end
