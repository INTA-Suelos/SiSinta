# -*- encoding : utf-8 -*-
require 'test_helper'

class UbicacionTest < ActiveSupport::TestCase

  setup do
    @atributos = {}
  end

  test "debería negarse a cargar la ubicación sin calicata" do
    assert Ubicacion.new(@atributos).invalid?, "una ubicación sin calicata es válida"
  end

  test "debería negarse a guardar un punto mal formado" do
    assert Ubicacion.new(:lat_lon => "sarasa").invalid?, "permite guardar 'sarasa' como latitud/longitud"
  end

end
