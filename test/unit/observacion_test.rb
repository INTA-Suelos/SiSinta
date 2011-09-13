# -*- encoding : utf-8 -*-
require 'test_helper'

class ObservacionTest < ActiveSupport::TestCase

  fixtures :all

  test "la fecha no puede ser del futuro" do
    o = Observacion.new :fecha => Date.today + 2
    assert_nil(h, "si se está cargando la observación es porque ya pasó")
  end

end
