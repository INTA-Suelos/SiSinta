require './test/test_helper'

class PosicionTest < ActiveSupport::TestCase
  subject { build(:posicion) }

  describe 'validaciones' do
    it 'es válido' do
      _(subject).must_be :valid?
    end

    it 'require valor' do
      _(build(:posicion, valor: nil)).wont_be :valid?
    end
  end
end
