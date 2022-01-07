require 'test_helper'

class ClaseDeEstructuraTest < ActiveSupport::TestCase
  subject { build :clase_de_estructura }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'no permite valores duplicados' do
      subject.save

      _(build(:clase_de_estructura, valor: subject.valor)).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :clase_de_estructura }
    let(:estructura) { create :estructura, clase: subject }

    it 'se recorre en ambos sentidos' do
      _(estructura.clase).must_equal subject

      _(subject.estructuras.first).must_equal estructura
    end
  end
end
