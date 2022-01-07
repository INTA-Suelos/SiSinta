require 'test_helper'

class AnegamientoTest < ActiveSupport::TestCase
  subject { create :anegamiento }

  describe 'validaciones' do
    it 'es válido' do
      _(subject).must_be :valid?
      _(build_stubbed(:anegamiento)).must_be :valid?
    end

    it 'require valor' do
      _(build_stubbed(:anegamiento, valor: nil)).wont_be :valid?
    end

    it 'require valor único' do
      _(build_stubbed(:anegamiento, valor: subject.valor)).wont_be :valid?
    end

    it 'permite valores duplicados en diferentes locales' do
      valor_es = subject.valor

      Globalize.with_locale :en do
        _(build_stubbed(:anegamiento, valor: valor_es)).must_be :valid?
      end
    end
  end
end
