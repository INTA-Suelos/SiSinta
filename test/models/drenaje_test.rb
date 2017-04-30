require './test/test_helper'

class DrenajeTest < ActiveSupport::TestCase
  subject { build(:drenaje) }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'require valor' do
      build(:drenaje, valor: nil).wont_be :valid?
    end
  end
end
