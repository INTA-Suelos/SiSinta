# encoding: utf-8
require './test/test_helper'

feature 'Sesión de usuario' do
  background do
    visit '/'
    click_link 'Entrar'
    assert_equal new_usuario_session_path, current_path
    assert page.has_css?('#usuario_email')
    assert page.has_css?('#usuario_password')

    u = create(:usuario)

    within 'form' do
      fill_in Usuario.human_attribute_name('email'),    with: u.email
      fill_in Usuario.human_attribute_name('password'), with: u.password

      click_button 'Entrar'
    end
  end

  scenario 'Después de loguearse avisa y va al root' do
    current_path.must_equal root_path
    page.must_have_selector '#flash_notice.mensaje', text: I18n.t('devise.sessions.signed_in')
  end

  scenario "Puede salir de la sesión" do
    click_link 'Salir'

    current_path.must_equal root_path
    page.must_have_selector '#flash_notice.mensaje', text: I18n.t('devise.sessions.signed_out')
  end
end
