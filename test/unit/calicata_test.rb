# -*- encoding : utf-8 -*-
require 'test_helper'

class CalicataTest < ActiveSupport::TestCase

  fixtures :all

  test "debería prohibir guardar calicatas sin fecha" do
    c = Calicata.new
    assert c.invalid?, "falta definir la fecha"
  end

  test "debería prohibir fechas del futuro" do
    c = Calicata.new :fecha => Date.today + 2
    assert c.invalid?, "la fecha es del futuro"
  end

  test "debería crear la calicata y objetos asociados" do
    atributos = { :fecha => Date.today,
                  :serie_attributes => {
                    :simbolo => "alguna serie" },
                  :paisaje_attributes => {},
                  :horizontes_attributes => [{}],
                  :fotos_attributes => [{}],
                  :capacidad_attributes => {
                    :subclases_attributes => [
                      {:codigo => 's'}],
                    :clase_attributes => {
                      :codigo => 'codigo'}}
                }
    c = Calicata.new(atributos)
    assert c.valid?, c.errors.full_messages.join(', ')
    assert_not_nil c.serie, "no se creó la serie"
    assert_not_nil c.paisaje, "no se creó el paisaje"
    assert_not_nil c.fotos, "no se crearon fotos"
    assert_not_nil c.horizontes, "no se crearon la horizontes"
    assert_not_nil c.capacidad, "no se creó la capacidad"
    assert_match /alguna serie/, c.serie.simbolo
    assert_match /codigo/, c.capacidad.clase.codigo
  end

end
