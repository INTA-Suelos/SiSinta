require './test/test_helper'

class LimiteTest < ActiveSupport::TestCase
  subject { build_stubbed :limite }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'requiere horizonte' do
      build(:limite, horizonte: nil).wont_be :valid?
    end
  end
end
