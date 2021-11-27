require './test/test_helper'

class FormaDeLimiteTest < ActiveSupport::TestCase
  subject { build :forma_de_limite }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere valor' do
      _(build(:forma_de_limite, valor: nil)).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :forma_de_limite }
    let(:limite) { create :limite, forma: subject }

    it 'se recorre en ambos sentidos' do
      _(limite.forma).must_equal subject

      _(subject.limites.first).must_equal limite
    end
  end
end
