require './test/test_helper'

class EscurrimientoTest < ActiveSupport::TestCase
  subject { build(:escurrimiento) }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'require valor' do
      build(:escurrimiento, valor: nil).wont_be :valid?
    end
  end
end
