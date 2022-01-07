require './test/test_helper'

class SalTest < ActiveSupport::TestCase
  subject { build(:sal) }

  describe 'validaciones' do
    it 'es válido' do
      _(subject).must_be :valid?
    end

    it 'require valor' do
      _(build(:sal, valor: nil)).wont_be :valid?
    end
  end
end
