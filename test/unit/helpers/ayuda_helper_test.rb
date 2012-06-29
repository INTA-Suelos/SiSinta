# -*- encoding : utf-8 -*-
require 'test_helper'
require 'ayuda_helper'

class AyudaHelperTest < ActionController::TestCase
  include AyudaHelper

  setup do
    @a = Ayuda.first
  end

  test "debería armar un div simple" do
    @response.body = ayuda_para(@a.campo)
    assert_select "div#ayuda_#{@a.campo.gsub('.', '_')}.ayuda", {count: 1, text: @a.ayuda}
  end

  test "debería armar un div con las clases especificadas" do
    @response.body = ayuda_para(@a.campo, {:clases => 'uno dos'})
    assert_select 'div.uno.dos', 1
  end

  test "debería armar un div con el id especificado" do
    @response.body = ayuda_para(@a.campo, {:id => 'algo'})
    assert_select 'div#algo.ayuda', 1
  end

end
