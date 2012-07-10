# -*- encoding : utf-8 -*-
require 'test_helper'

class SeedTest < ActiveSupport::TestCase

  test "deberían cargarse las semillas de capacidad" do
    assert_not_nil ClaseDeCapacidad.first, "no se cargaron las clases de capacidad"
    assert_not_nil SubclaseDeCapacidad.first, "no se cargaron las subclases de capacidad"
  end

  test "deberían cargarse las semillas de relieve" do
    assert_not_nil Relieve.first, "no se cargaron los relieves"
  end

  test "deberían cargarse las semillas de posición" do
    assert_not_nil Posicion.first, "no se cargaron las posiciones"
  end

  test "deberían cargarse las semillas de pendiente" do
    assert_not_nil Pendiente.first, "no se cargaron las pendientes"
  end

  test "deberían cargarse las semillas de pedregosidad" do
    assert_not_nil Pedregosidad.first, "no se cargaron las pedregosidades"
  end

  test "deberían cargarse las semillas de escurrimiento" do
    assert_not_nil Escurrimiento.first, "no se cargaron los escurrimientos"
  end

  test "deberían cargarse las semillas de permeabilidad" do
    assert_not_nil Permeabilidad.first, "no se cargaron las permeabilidades"
  end

  test "deberían cargarse las semillas de drenaje" do
    assert_not_nil Drenaje.first, "no se cargaron los drenajes"
  end

  test "deberían cargarse las semillas de anegamiento" do
    assert_not_nil Anegamiento.first, "no se cargaron los anegamientos"
  end

  test "deberían cargarse los roles iniciales" do
    assert_not_nil Rol.first, "no se cargaron los roles"
  end

  test "deberían cargarse los colores" do
    assert_not_nil Color.first, "no se cargaron los colores"
  end

  test "debería existir un rol de administrador" do
    assert_not_nil Rol.find_by_nombre('administrador'), "no hay un rol administrador"
    assert_instance_of Rol, Rol.administrador
  end

end
