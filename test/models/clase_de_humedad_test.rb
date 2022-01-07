require 'test_helper'

class ClaseDeHumedadTest < ActiveSupport::TestCase
  subject { build_stubbed :clase_de_humedad }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere valor' do
      _(build_stubbed(:clase_de_humedad, valor: nil)).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :clase_de_humedad }
    let(:humedad) { create :humedad, clase: subject }

    it 'se recorre en ambos sentidos' do
      _(humedad.clase).must_equal subject

      _(subject.humedades.first).must_equal humedad
    end
  end
end
