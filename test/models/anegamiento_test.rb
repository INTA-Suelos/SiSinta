require 'test_helper'

class AnegamientoTest < ActiveSupport::TestCase
  subject { create :anegamiento }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'require valor' do
      build_stubbed(:anegamiento, valor: nil).wont_be :valid?
    end

    it 'require valor único' do
      build_stubbed(:anegamiento, valor: subject.valor).wont_be :valid?
    end

    it 'permite valores duplicados en diferentes locales' do
      valor_es = subject.valor

      Globalize.with_locale :en do
        build_stubbed(:anegamiento, valor: valor_es).must_be :valid?
      end
    end
  end
end
