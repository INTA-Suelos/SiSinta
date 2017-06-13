require 'test_helper'

describe InicioController do
  it 'va al inicio' do
    get :index

    must_respond_with :success
  end

  describe 'locales' do
    subject { @controller }

    it 'usa :es por default' do
      get :index

      subject.locale.must_equal :es
    end

    it 'cambia el locale desde la url' do
      get :index, locale: 'en'

      subject.locale.must_equal :en
    end
  end
end
