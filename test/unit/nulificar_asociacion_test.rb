# encoding: utf-8
require './test/test_helper'

class NulificarAsociacionTest < ActiveSupport::TestCase
  test "debería nulificar la asociación" do
    p = build_stubbed(:perfil, fase: build_stubbed(:fase))
    assert_not_nil p.fase
    p.anular = 'fase'
    assert_nil p.fase
  end
end
