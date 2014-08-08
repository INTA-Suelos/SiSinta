# encoding: utf-8
require './test/test_helper'

feature 'Exportar CSV' do
  scenario 'puede acceder a la página' do
    usuario = loguearse_como 'Autorizado'
    perfil = create(:perfil_completo, usuario: usuario).decorate

    visit exportar_perfiles_path
    current_path.must_equal exportar_perfiles_path

    # TODO completar
  end
end
