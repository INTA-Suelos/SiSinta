# encoding: utf-8
require './test/test_helper'

feature 'Sesión de usuario' do
  background do
    @usuario = create(:usuario)
  end

  scenario 'Puede loguearse exitosamente' do
    visit root_path
    click_link 'Entrar'

    _(current_path).must_equal new_usuario_session_path

    _(page).must_have_selector '#usuario_email'
    _(page).must_have_selector '#usuario_password'

    within 'form' do
      fill_in Usuario.human_attribute_name('email'),    with: @usuario.email
      fill_in Usuario.human_attribute_name('password'), with: @usuario.password

      click_button 'Entrar'
    end

    _(current_path).must_equal root_path
    _(page).must_have_selector '.mensaje', text: I18n.t('devise.sessions.signed_in')
  end

  feature 'Estando logueado' do
    background do
      loguear @usuario
    end

    scenario 'Puede salir de la sesión' do
      visit root_path
      click_link 'Salir'

      _(current_path).must_equal root_path
      _(page).must_have_selector '#flash_notice.mensaje', text: I18n.t('devise.sessions.signed_out')
    end
  end
end
