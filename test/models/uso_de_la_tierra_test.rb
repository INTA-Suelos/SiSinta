require './test/test_helper'

class UsoDeLaTierraTest < ActiveSupport::TestCase
  subject { build(:uso_de_la_tierra) }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'require valor' do
      build(:uso_de_la_tierra, valor: nil).wont_be :valid?
    end
  end
end
