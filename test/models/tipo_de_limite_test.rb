require './test/test_helper'

class TipoDeLimiteTest < ActiveSupport::TestCase
  subject { build :tipo_de_limite }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build(:tipo_de_limite, valor: nil).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :tipo_de_limite }
    let(:limite) { create :limite, tipo: subject }

    it 'se recorre en ambos sentidos' do
      limite.tipo.must_equal subject

      subject.limites.first.must_equal limite
    end
  end
end
