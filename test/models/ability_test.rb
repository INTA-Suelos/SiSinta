# encoding : utf-8
require './test/test_helper'

class AbilityTest < ActiveSupport::TestCase

  test "los administradores pueden tocar todo" do
    admin = create(:usuario, rol: 'Administrador')
    permisos = Ability.new admin

    permisos.recursos.each do |recurso|
      assert permisos.can?(:manage, recurso), "Debe poder administrar #{recurso}"
    end
    assert permisos.can?(:manage, Usuario), "Debe poder administrar Usuario"
  end

  test "los usuarios autorizados pueden ver cualquier objeto" do
    autorizado = create(:usuario, rol: 'Autorizado')
    permisos = Ability.new autorizado

    perfil_ajeno = build_stubbed(:perfil, usuario: create(:usuario))

    assert permisos.can?(:read, perfil_ajeno), "Debe poder ver un perfil ajeno"
    assert permisos.cannot(:update, perfil_ajeno), "No debe poder cambiar un perfil ajeno"
    assert permisos.cannot(:destroy, perfil_ajeno), "No debe poder destruir un perfil ajeno"
    assert permisos.cannot(:manage, perfil_ajeno), "No debe poder administrar un perfil ajeno"
    assert permisos.cannot(:modificar, perfil_ajeno), "No debe poder modificar un perfil ajeno"
  end

  test "los usuarios autorizados pueden crear objetos propios" do
    autorizado = create(:usuario, rol: 'Autorizado')
    permisos = Ability.new autorizado

    permisos.recursos.each do |recurso|
      assert permisos.can?(:create, recurso), "Debe poder crear #{recurso}"
    end
  end

  test "los usuarios autorizados pueden manejar sus propios objetos" do
    autorizado = create(:usuario, rol: 'Autorizado')
    otro_usuario = create(:usuario, rol: 'Administrador')
    permisos = Ability.new autorizado

    [:perfil, :equipo, :proyecto, :serie].collect do |modelo|
      propio = build_stubbed(modelo, usuario: autorizado)
      ajeno = build_stubbed(modelo, usuario: otro_usuario)
      huerfano = build_stubbed(modelo, usuario: nil)

      assert permisos.can?(:manage, propio), "Deben poder administrar sus recursos"
      assert permisos.cannot?(:manage, ajeno), "No deben poder administrar otros"
      assert permisos.cannot?(:manage, huerfano), "No deben poder administrar otros"
    end
  end

  test "los miembros de un equipo pueden editar el equipo y agregar miembros" do
    equipo = create(:equipo, miembros: 3)
    equipo.miembros.each do |miembro|
      miembro.grant 'Autorizado'
      permisos = Ability.new miembro
      assert permisos.can?(:update, equipo), "Un miembro debe poder actualizar sus equipos"
    end
  end

  test "los miembros de algo pueden administrarlo" do
    miembro = create(:usuario)
    perfil = create(:perfil)
    miembro.grant 'Miembro', perfil
    permisos = Ability.new miembro

    assert permisos.can?(:modificar, perfil),
      "No puede administrar un perfil del que es miembro"
    refute permisos.can?(:modificar, create(:perfil)),
      "Puede administrar un perfil del que no es miembro"
  end

  test "los miembros de algo pueden autocompletar tags" do
    miembro = create(:usuario)
    perfil = create(:perfil)
    miembro.grant 'Miembro', perfil
    permisos = Ability.new miembro

    assert permisos.can?(:autocomplete_reconocedores_name, Perfil),
      "Debe poder autocompletar los reconocedores si es miembro de algún perfil"
    assert permisos.can?(:autocomplete_etiquetas_name, Perfil),
      "Debe poder autocompletar las etiquetas si es miembro de algún perfil"
  end

  test "los invitados no pueden crear o modificar recursos" do
    permisos = Ability.new

    permisos.recursos.each do |recurso|
      case recurso.name
        when 'Busqueda'
          [:update, :destroy].each do |accionar|
            assert permisos.cannot?(accionar, recurso), "No debe poder #{accionar} sobre #{recurso}"
          end
          assert permisos.can?(:create, recurso), 'Debe poder crear búsquedas'
        else
          [:create, :update, :destroy].each do |accionar|
            assert permisos.cannot?(accionar, recurso), "No debe poder #{accionar} sobre #{recurso}"
          end
      end
    end
  end

  test "los invitados sólo pueden leer perfiles que son públicos" do
    permisos = Ability.new
    perfil_privado = build_stubbed(:perfil)
    perfil_publico = build_stubbed(:perfil, publico: true)

    assert permisos.cannot?(:read, perfil_privado), "No debe poder ver perfiles privados"
    assert permisos.can?(:read, perfil_publico), "Debe poder ver perfiles públicos"
  end

  test "los invitados pueden leer recursos básicos" do
    permisos = Ability.new

    permisos.recursos.each do |recurso|
      assert permisos.can?(:read, recurso), "Debe poder leer recursos básicos"
    end
  end
end
