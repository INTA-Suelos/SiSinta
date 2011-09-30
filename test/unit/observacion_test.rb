# -*- encoding : utf-8 -*-
require 'test_helper'

class ObservacionTest < ActiveSupport::TestCase

  fixtures :all

  test "debería prohibir fechas del futuro" do
    o = Observacion.new :fecha => Date.today + 2
    assert(!o.valid?, "se guardó una fecha que no ha llegado")
  end

end
