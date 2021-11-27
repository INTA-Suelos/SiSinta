# encoding : utf-8
require './test/test_helper'

class AbilityTest < ActiveSupport::TestCase
  describe 'administradoras' do
    let(:admin) { create(:usuario, rol: 'Administrador') }
    let(:permisos) { Ability.new admin }

    it 'pueden administrar cualquier recurso' do
      permisos.recursos.each do |recurso|
        _(permisos.can?(:manage, recurso)).must_equal true, "Debe poder administrar #{recurso}"
      end
    end

    it 'pueden administrar usuarios' do
      _(permisos.can?(:manage, Usuario)).must_equal true
    end
  end

  describe 'autorizadas' do
    let(:autorizado) { create :usuario, rol: 'Autorizado' }
    let(:permisos) { Ability.new autorizado }
    let(:otro_usuario) { create :usuario, rol: 'Administrador' }

    it 'pueden leer cualquier recurso' do
      permisos.recursos.each do |recurso|
        _(permisos.can?(:read, recurso)).must_equal true, "Debe poder leer #{recurso}"
      end
    end

    it 'pueden modificar perfiles propios' do
      perfil_propio = build_stubbed :perfil, usuario: autorizado

      _(permisos.can?(:update, perfil_propio)).must_equal true
      _(permisos.can?(:destroy, perfil_propio)).must_equal true
      _(permisos.can?(:manage, perfil_propio)).must_equal true
      _(permisos.can?(:modificar, perfil_propio)).must_equal true
    end

    it 'no pueden modificar perfiles ajenos' do
      perfil_ajeno = build_stubbed :perfil, usuario: create(:usuario)

      _(permisos.can?(:update, perfil_ajeno)).wont_equal true
      _(permisos.can?(:destroy, perfil_ajeno)).wont_equal true
      _(permisos.can?(:manage, perfil_ajeno)).wont_equal true
      _(permisos.can?(:modificar, perfil_ajeno)).wont_equal true
    end

    it 'pueden crear cualquier tipo de recurso' do
      permisos.recursos.each do |recurso|
        _(permisos.can?(:create, recurso)).must_equal true, "Debe poder crear #{recurso}"
      end
    end

    it 'pueden administrar sus propios objetos' do
      [:perfil, :equipo, :proyecto, :serie].each do |modelo|
        _(permisos.can?(:manage, build_stubbed(modelo, usuario: autorizado))).must_equal true
      end
    end

    it 'no pueden administrar objetos que no poseen' do
      [:perfil, :equipo, :proyecto, :serie].each do |modelo|
        ajeno = build_stubbed(modelo, usuario: otro_usuario)
        huerfano = build_stubbed(modelo, usuario: nil)

        _(permisos.can?(:manage, ajeno)).wont_equal true,
          "No deben poder administrar un/a #{modelo} que no poseen"
        _(permisos.can?(:manage, huerfano)).wont_equal true,
          "No deben poder administrar un/a #{modelo} que no poseen"
      end
    end

    it 'pueden modificar el equipo al que pertenecen' do
      equipo = create :equipo
      equipo.miembros << autorizado

      _(permisos.can?(:update, equipo)).must_equal true
    end
  end

  describe 'miembros' do
    let(:perfil) { create(:perfil) }
    let(:miembro) do
      usuario = create(:usuario)
      usuario.grant 'Miembro', perfil
      usuario
    end
    let(:permisos) { Ability.new miembro }

    it 'pueden modificar perfiles para los que tienen permiso explícito' do
      _(permisos.can?(:modificar, perfil)).must_equal true
    end

    it 'no pueden modificar perfiles para los que no tienen permiso explícito' do
      _(permisos.can?(:modificar, create(:perfil))).wont_equal true
    end

    it 'los miembros de algo pueden autocompletar tags' do
      _(permisos.can?(:autocomplete_reconocedores_name, Perfil)).must_equal true
      _(permisos.can?(:autocomplete_etiquetas_name, Perfil)).must_equal true
    end
  end

  describe 'invitadas' do
    let(:permisos) { Ability.new }

    it 'no pueden crear ni modificar recursos' do
      permisos.recursos.each do |recurso|
        unless recurso.name == 'Busqueda'
          [:create, :update, :destroy].each do |accionar|
            _(permisos.can?(accionar, recurso)).wont_equal true, "No debe poder #{accionar} sobre #{recurso}"
          end
        end
      end
    end

    it 'pueden crear Busquedas' do
      _(permisos.can?(:create, Busqueda)).must_equal true
    end

    it 'pueden leer perfiles públicos' do
      perfil_publico = build_stubbed(:perfil, publico: true)

      _(permisos.can?(:read, perfil_publico)).must_equal true
    end

    it 'no pueden leer perfiles privados' do
      perfil_privado = build_stubbed(:perfil)

      _(permisos.can?(:read, perfil_privado)).wont_equal true
    end

    it 'pueden leer recursos básicos' do
      permisos.recursos.each do |recurso|
        _(permisos.can?(:read, recurso)).must_equal true, "Debe poder leer #{recurso}"
      end
    end
  end
end
