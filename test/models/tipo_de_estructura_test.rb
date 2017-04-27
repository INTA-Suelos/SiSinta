require 'test_helper'

class TipoDeEstructuraTest < ActiveSupport::TestCase
  subject { build :tipo_de_estructura }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'no permite valores duplicados' do
      subject.save

      build(:tipo_de_estructura, valor: subject.valor).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :tipo_de_estructura }
    let(:estructura) { create :estructura, tipo: subject }

    it 'se recorre en ambos sentidos' do
      estructura.tipo.must_equal subject

      subject.estructuras.first.must_equal estructura
    end
  end
end
