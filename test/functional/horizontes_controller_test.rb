# encoding: utf-8
require './test/test_helper'

class HorizontesControllerTest < ActionController::TestCase
  test "rutea a exportar" do
    assert_routing({
      path: "/horizontes/exportar",
      method: :get
    },{
      controller: 'horizontes', action: 'exportar'
    })
  end

  test "rutea a procesar_csv" do
    assert_routing({
      path: "/horizontes/procesar_csv",
      method: :post
    },{
      controller: 'horizontes', action: 'procesar_csv'
    })
  end
end
