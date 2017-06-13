require './test/test_helper'

describe Adjunto do
  let(:perfil) { create(:perfil) }
  let(:adjunto) { create :adjunto, perfil: perfil }
  let(:danger) do
    Rack::Test::UploadedFile.new Rails.root.join('test', 'data', 'falso.jpg'), 'image/png'
  end

  it 'está configurado' do
    Rails.configuration.adjunto_path.wont_be_nil
  end

  it 'no valida el media type' do
    build(:adjunto, perfil: perfil, archivo: danger).must_be :valid?
  end

  describe '#extension' do
    it 'devuelve la extensión del archivo' do
      adjunto.extension.wont_be_nil
    end
  end

  describe '#publico' do
    it 'se sincroniza con su perfil al guardar' do
      # Diferente visibilidad
      perfil.update_attribute :publico, !adjunto.publico

      adjunto.save && adjunto.publico.must_equal(perfil.publico)
    end

    # Test de regresión por #124
    # https://github.com/INTA-Suelos/SiSinta/issues/124
    it 'al guardarse el perfil se sincroniza su adjunto' do
      # Misma visibilidad
      perfil.update_attribute :publico, adjunto.publico

      perfil.publico = perfil.reload.publico
      perfil.save

      adjunto.reload.publico.must_equal(perfil.publico)
    end
  end

  describe '#sincronizar_visibilidad_perfil' do
    it 'se sincroniza con su perfil' do
      perfil.update_attribute :publico, !adjunto.publico

      adjunto.sincronizar_visibilidad_perfil

      adjunto.publico.must_equal perfil.publico
    end
  end
end
