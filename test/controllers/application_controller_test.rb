require 'test_helper'

describe ApplicationController do
  subject { @controller }

  describe 'locales' do
    it 'permite locales conocidos' do
      _(subject.elegir_locale('es')).must_equal 'es'
      _(subject.elegir_locale('en')).must_equal 'en'
    end

    it 'usa el default para locales desconocidos' do
      _(subject.elegir_locale('danger!')).must_equal I18n.default_locale
    end

    it 'prefiere el locale del usuario antes que el default' do
      anglo = create :usuario, idioma: 'en'

      subject.stub :current_usuario, anglo do
        _(subject.elegir_locale('danger!')).must_equal 'en'
      end
    end
  end
end
