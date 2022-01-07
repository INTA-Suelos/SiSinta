require './test/test_helper'

class EscurrimientoTest < ActiveSupport::TestCase
  subject { build(:escurrimiento) }

  describe 'validaciones' do
    it 'es válido' do
      _(subject).must_be :valid?
    end

    it 'require valor' do
      _(build(:escurrimiento, valor: nil)).wont_be :valid?
    end
  end
end
