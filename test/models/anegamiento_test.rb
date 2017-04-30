require './test/test_helper'

class AnegamientoTest < ActiveSupport::TestCase
  subject { build(:anegamiento) }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'require valor' do
      build(:anegamiento, valor: nil).wont_be :valid?
    end
  end
end
