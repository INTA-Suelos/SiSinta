require './test/test_helper'

class TexturaTest < ActiveSupport::TestCase
  subject { build(:textura) }

  describe 'validaciones' do
    it 'es válido' do
      _(subject).must_be :valid?
    end

    it 'require clase' do
      _(build(:textura, clase: nil)).wont_be :valid?
    end

    it 'no requiere textura' do
      _(build(:textura, textura: nil)).must_be :valid?
    end

    it 'no requiere suelo' do
      _(build(:textura, suelo: nil)).must_be :valid?
    end
  end
end
