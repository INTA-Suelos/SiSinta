# encoding: utf-8
require './test/test_helper'

class LoginTest < ActionDispatch::IntegrationTest

  test "puede iniciar sesión" do
    click_link 'Entrar'
    assert_equal new_usuario_session_path, current_path 
    assert page.has_css?('#usuario_email')
    assert page.has_css?('#usuario_password')

    within 'form' do
      fill_in Usuario.human_attribute_name('email'),    with: u.email
      fill_in Usuario.human_attribute_name('password'), with: u.password

      click_button 'Entrar'
    end

    assert_equal root_path, current_path
    assert page.has_css?('#flash_notice.mensaje',
            text: I18n.t('devise.sessions.signed_in')), "No se loguea"
  end

end
