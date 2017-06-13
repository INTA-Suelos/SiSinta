require 'test_helper'

describe ApplicationController do
  subject { @controller }

  describe 'locales' do
    it 'permite locales conocidos' do
      subject.locale_sanitizado('es').must_equal 'es'
      subject.locale_sanitizado('en').must_equal 'en'
    end

    it 'usa el default para locales desconocidos' do
      subject.locale_sanitizado('danger!').must_equal I18n.default_locale
    end
  end
end
