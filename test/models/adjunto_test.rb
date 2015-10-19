# encoding: utf-8
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
    it 'lo delega a perfil' do
      perfil.update_attribute :publico, !adjunto.publico

      adjunto.publico.must_equal perfil.publico
    end
  end
end
