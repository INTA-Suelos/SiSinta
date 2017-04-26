require './test/test_helper'

class FormaDeLimiteTest < ActiveSupport::TestCase
  subject { build :forma_de_limite }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build(:forma_de_limite, valor: nil).wont_be :valid?
    end
  end
end
