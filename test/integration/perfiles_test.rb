# encoding: utf-8
require './test/test_helper'

feature 'Carga de perfiles' do
  background do
    @usuario = loguearse_como 'Autorizado'
    @perfil = create(:perfil, usuario: @usuario).decorate
    visit edit_perfil_path(@perfil)
  end

  after { logout }

  feature 'La fecha está en formato dd/mm/aaaa' do
    scenario 'Decora la fecha existente' do
      within 'form' do
        has_selector?('#perfil_fecha').must_equal true
        find_field('Fecha').value.must_equal @perfil.fecha
      end
    end

    scenario 'Acepta fechas en formato humano' do
      within 'form' do
        fill_in Perfil.human_attribute_name('fecha'),    with: '23/3/1987'
        click_button 'Actualizar Perfil'
      end

      current_path.must_equal perfil_path(@perfil)
      # TODO usar la GUI para verificarlo
      @perfil.reload.decorate.fecha.must_equal '23/03/1987'
    end
  end

  feature 'Datos de series a través del perfil' do
    scenario 'Crea una serie' do
      Serie.count.must_equal 0

      within 'form' do
        within '#serie' do
          fill_in Serie.human_attribute_name('nombre'),   with: 'Sarasa'
          fill_in Serie.human_attribute_name('simbolo'),  with: 'Sa'
        end

        click_button 'Actualizar Perfil'
      end

      current_path.must_equal perfil_path(@perfil)

      Serie.count.must_equal 1
      Serie.first.nombre.must_equal 'Sarasa'
      Serie.first.simbolo.must_equal 'Sa'
    end

    scenario 'Asocia una serie existente' do
      serie = create(:serie)
      serie.perfiles.count.must_equal 0

      within 'form' do
        within '#serie' do
          fill_in Serie.human_attribute_name('nombre'),   with: serie.nombre
          fill_in Serie.human_attribute_name('simbolo'),  with: serie.simbolo
        end

        click_button 'Actualizar Perfil'
      end

      current_path.must_equal perfil_path(@perfil)

      Serie.count.must_equal 1
      serie.perfiles.count.must_equal 1
    end

    scenario 'Asigna el símbolo a una serie existente' do
      serie = create(:serie, simbolo: nil)
      serie.simbolo.must_be_nil

      within 'form' do
        within '#serie' do
          fill_in Serie.human_attribute_name('nombre'),   with: serie.nombre
          fill_in Serie.human_attribute_name('simbolo'),  with: 'Fa'
        end

        click_button 'Actualizar Perfil'
      end

      current_path.must_equal perfil_path(@perfil)

      serie.reload.simbolo.wont_be_nil
      serie.simbolo.must_equal 'Fa'
    end
  end
end
