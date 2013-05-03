# encoding: utf-8
require './test/test_helper'

class PerfilesTest < ActionDispatch::IntegrationTest

  test "fecha en formato dd/mm/aaaa" do
    usuario = loguearse_como 'Autorizado'
    perfil = create(:perfil, usuario: usuario).decorate

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
end
