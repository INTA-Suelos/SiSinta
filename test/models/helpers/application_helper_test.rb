require './test/test_helper'
require 'application_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  test 'genera un div simple' do
    render text: ayuda_para('este texto')
    assert_select 'div.ayuda', { count: 1, text: 'este texto' }
  end

  test 'genera un div con las clases especificadas' do
    render text: ayuda_para('algo', { clases: 'uno dos' })
    assert_select 'div.uno.dos', 1
  end

  test 'genera un div con el id especificado' do
    render text: ayuda_para('algo', { id: 'especificado' })
    assert_select 'div#especificado.ayuda', 1
  end
end
