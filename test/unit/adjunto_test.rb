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
    adjunto = create(:adjunto)
    assert_equal adjunto.perfil.publico, adjunto.publico
    adjunto.perfil.publico = !adjunto.perfil.publico
    assert_equal adjunto.perfil.publico, adjunto.publico
    adjunto.perfil = nil
    assert_nil adjunto.publico
  end

end
