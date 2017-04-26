require './test/test_helper'

class ClaseDeErosionTest < ActiveSupport::TestCase
  subject { build :clase_de_erosion }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build(:clase_de_erosion, valor: nil).wont_be :valid?
    end
  end
end
