require './test/test_helper'

describe Consistencia do
  subject { build_stubbed(:consistencia) }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere Horizonte' do
      _(build_stubbed(:consistencia, horizonte: nil)).wont_be :valid?
    end
  end
end
