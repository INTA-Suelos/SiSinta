require 'test_helper'

feature 'Carga de perfiles' do
  describe 'Formulario clásico' do
    background do
      create(:ficha, identificador: 'clasico', default: true)
      @usuario = loguearse_como 'Autorizado'
      @perfil = create(:perfil, usuario: @usuario).decorate
      visit edit_perfil_path(@perfil)
    end

    after { logout }

    feature 'La fecha está en formato dd/mm/aaaa' do
      scenario 'Decora la fecha existente' do
        within 'form.completa' do
          _(has_selector?('#perfil_fecha')).must_equal true
          _(find_field('Fecha').value).must_equal @perfil.fecha
        end
      end

      scenario 'Acepta fechas en formato humano' do
        within 'form.completa' do
          fill_in Perfil.human_attribute_name('fecha'),    with: '23/3/1987'
          click_button 'Actualizar Perfil'
        end

        _(current_path).must_equal perfil_path(@perfil)
        # TODO usar la GUI para verificarlo
        _(@perfil.reload.decorate.fecha).must_equal '23/03/1987'
      end
    end

    feature 'Datos de series a través del perfil' do
      scenario 'Crea una serie' do
        _(Serie.count).must_equal 0

        within 'form.completa' do
          within '#serie' do
            fill_in Serie.human_attribute_name('nombre'),   with: 'Sarasa'
            fill_in Serie.human_attribute_name('simbolo'),  with: 'Sa'
          end

          click_button 'Actualizar Perfil'
        end

        _(current_path).must_equal perfil_path(@perfil)

        _(Serie.count).must_equal 1
        _(Serie.first.nombre).must_equal 'Sarasa'
        _(Serie.first.simbolo).must_equal 'Sa'
      end

      scenario 'Asocia una serie existente' do
        serie = create(:serie)
        _(serie.perfiles.count).must_equal 0

        within 'form.completa' do
          within '#serie' do
            fill_in Serie.human_attribute_name('nombre'),   with: serie.nombre
            fill_in Serie.human_attribute_name('simbolo'),  with: serie.simbolo
          end

          click_button 'Actualizar Perfil'
        end

        _(current_path).must_equal perfil_path(@perfil)

        _(Serie.count).must_equal 1
        _(serie.perfiles.count).must_equal 1
      end

      scenario 'Asigna el símbolo a una serie existente' do
        serie = create(:serie, simbolo: nil)
        _(serie.simbolo).must_be_nil

        within 'form.completa' do
          within '#serie' do
            fill_in Serie.human_attribute_name('nombre'),   with: serie.nombre
            fill_in Serie.human_attribute_name('simbolo'),  with: 'Fa'
          end

          click_button 'Actualizar Perfil'
        end

        _(current_path).must_equal perfil_path(@perfil)

        _(serie.reload.simbolo).wont_be_nil
        _(serie.simbolo).must_equal 'Fa'
      end
    end
  end
end
