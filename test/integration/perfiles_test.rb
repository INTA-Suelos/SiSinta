# encoding: utf-8
require './test/test_helper'

feature 'Carga de perfiles' do
  background { loguearse_como 'Autorizado' }

  after { logout }

  scenario "fecha en formato dd/mm/aaaa" do
    perfil = create(:perfil, usuario: @usuario)
    visit edit_perfil_path(perfil)
    current_path.must_equal edit_perfil_path(perfil)

    within 'form' do
      has_selector?('#perfil_fecha').must_equal true
      find_field('Fecha').value.must_equal perfil.fecha

      fill_in Perfil.human_attribute_name('fecha'),    with: '23/3/1987'
      click_button 'Actualizar Perfil'
    end

    perfil.reload.decorate.fecha.must_equal '23/03/1987'
  end

  scenario "crea la serie a través del perfil" do
    Serie.count.must_equal 0

    visit new_perfil_path
    within 'form' do
      within '#serie' do
        fill_in Serie.human_attribute_name('nombre'),    with: 'Sarasa'
        fill_in Serie.human_attribute_name('simbolo'),    with: 'Sa'
      end

      completar_datos_de_perfil_requeridos

      click_button 'Crear Perfil'
    end

    Serie.count.must_equal 1
    Serie.first.nombre.must_equal 'Sarasa'
    Serie.first.simbolo.must_equal 'Sa'
  end

  scenario "asocia la serie a través del perfil" do
    serie = create(:serie)
    Serie.count.must_equal 1
    serie.perfiles.count.must_equal 0

    visit new_perfil_path
    within 'form' do
      within '#serie' do
        fill_in Serie.human_attribute_name('nombre'),    with: serie.nombre
        fill_in Serie.human_attribute_name('simbolo'),    with: serie.simbolo
      end

      completar_datos_de_perfil_requeridos
      click_button 'Crear Perfil'
    end

    Serie.count.must_equal 1
    serie.perfiles.count.must_equal 1
  end

  scenario "asigna un símbolo a la serie a través del perfil" do
    serie = create(:serie, simbolo: nil)
    serie.simbolo.must_be_nil

    visit new_perfil_path
    within 'form' do
      within '#serie' do
        fill_in Serie.human_attribute_name('nombre'),    with: serie.nombre
        fill_in Serie.human_attribute_name('simbolo'),    with: 'Fa'
      end

      completar_datos_de_perfil_requeridos
      click_button 'Crear Perfil'
    end

    serie.reload.simbolo.wont_be_nil
    serie.simbolo.must_equal 'Fa'
  end
end
