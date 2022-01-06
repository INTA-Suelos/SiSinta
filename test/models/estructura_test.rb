require 'test_helper'

class EstructuraTest < ActiveSupport::TestCase
  subject { build_stubbed :estructura }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere horizonte' do
      _(build_stubbed(:estructura, horizonte: nil)).wont_be :valid?
    end
  end
end
