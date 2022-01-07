require './test/test_helper'

class RelieveTest < ActiveSupport::TestCase
  subject { build(:relieve) }

  describe 'validaciones' do
    it 'es válido' do
      _(subject).must_be :valid?
    end

    it 'require valor' do
      _(build(:relieve, valor: nil)).wont_be :valid?
    end
  end
end
