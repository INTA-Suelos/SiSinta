require './test/test_helper'

class TexturaTest < ActiveSupport::TestCase
  subject { build(:textura) }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'require clase' do
      build(:textura, clase: nil).wont_be :valid?
    end

    it 'no requiere textura' do
      build(:textura, textura: nil).must_be :valid?
    end

    it 'no requiere suelo' do
      build(:textura, suelo: nil).must_be :valid?
    end
  end
end
