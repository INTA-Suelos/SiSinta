# encoding: utf-8
require './test/test_helper'

class AdjuntoTest < ActiveSupport::TestCase

  setup do
    @perfil = create(:perfil)
    @adjunto = create(:adjunto, perfil: @perfil)
  end

  test 'está configurado' do
    assert_not_nil Rails.configuration.adjunto_path
  end

  test 'devuelve la extensión del archivo' do
    adjunto = create(:adjunto)
    assert_not_nil adjunto.extension
  end

  test 'delega publico a perfil' do
    assert_equal @perfil.publico, @adjunto.publico
    @perfil.publico = !@perfil.publico
    assert_equal @perfil.publico, @adjunto.publico
  end

  test 'no valida el media type' do
    falso = Rack::Test::UploadedFile.new Rails.root.join('test', 'data', 'falso.jpg'), 'image/png'

    build(:adjunto, perfil: @perfil, archivo: falso).must_be :valid?
  end
end
