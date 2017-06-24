require 'test_helper'

describe InicioController do
  it 'va al inicio' do
    get :index

    must_respond_with :success
  end

  describe 'locales' do
    subject { @controller }

    describe 'a través de params[:locale]' do
      it 'usa :es por default' do
        get :index

        subject.locale.must_equal :es
      end

      it 'cambia el locale desde la url' do
        get :index, locale: 'en'

        subject.locale.must_equal :en
      end
    end

    describe 'a través del usuario actual' do
      let(:anglo) { create :usuario, idioma: 'en' }

      it 'usa el preferido del usuario por default' do
        loguear anglo

        get :index

        subject.locale.must_equal :en
      end

      it 'se prioriza el locale desde la url' do
        loguear anglo

        get :index, locale: 'es'

        subject.locale.must_equal :es
      end
    end
  end
end
