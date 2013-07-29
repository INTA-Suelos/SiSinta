# encoding: utf-8
require './test/test_helper'

class AdjuntoTest < ActiveSupport::TestCase

  test 'está configurado' do
    assert_not_nil Rails.configuration.adjunto_path
  end

  test 'devuelve la extensión del archivo' do
    adjunto = create(:adjunto)
    assert_not_nil adjunto.extension
  end

  test 'delega publico a perfil' do
    perfil = create(:perfil)
    adjunto = create(:adjunto, perfil: perfil)
    assert_equal perfil.publico, adjunto.publico
    perfil.publico = !perfil.publico
    assert_equal perfil.publico, adjunto.publico
  end

end
