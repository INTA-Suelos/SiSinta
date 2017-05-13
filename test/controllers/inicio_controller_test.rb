require 'test_helper'

describe InicioController do
  it 'va al inicio' do
    get :index

    must_respond_with :success
  end
end
