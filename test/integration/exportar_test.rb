# encoding: utf-8
require './test/test_helper'

class ExportarTest < ActionDispatch::IntegrationTest

  test "exporta csv" do
    usuario = loguearse_como 'Autorizado'
    perfil = create(:perfil_completo, usuario: usuario).decorate

    visit exportar_perfiles_path
    current_path.must_equal exportar_perfiles_path

    # TODO completar
  end

end
