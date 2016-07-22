require './test/test_helper'

class RelieveTest < ActiveSupport::TestCase
  subject { build(:relieve) }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'require valor' do
      build(:relieve, valor: nil).wont_be :valid?
    end
  end
end
