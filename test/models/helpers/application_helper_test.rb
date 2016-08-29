require './test/test_helper'

class ApplicationHelperTest < ActionView::TestCase
  it 'genera un div simple' do
    render text: ayuda_para('este texto')

    must_select 'div.ayuda', { count: 1, text: 'este texto' }
  end

  it 'genera un div con las clases especificadas' do
    render text: ayuda_para('algo', { clases: 'uno dos' })

    must_select 'div.uno.dos', 1
  end

  it 'genera un div con el id especificado' do
    render text: ayuda_para('algo', { id: 'especificado' })

    must_select 'div#especificado.ayuda', 1
  end
end
