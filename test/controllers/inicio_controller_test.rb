# encoding: utf-8
require './test/test_helper'

class InicioControllerTest < ActionController::TestCase

  test "va al inicio" do
    get :index
    assert_response :success
  end

end
