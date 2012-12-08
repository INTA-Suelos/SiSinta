# encoding: utf-8
require 'test_helper'

class SerieTest < ActiveSupport::TestCase

  test "debería requerir el nombre" do
    assert build_stubbed(:serie_anonima).invalid?, "Valida sin nombre"
  end

  test "no debería permitir nombres duplicados" do
    existente = create(:serie).nombre
    assert build_stubbed(:serie, nombre: existente).invalid?, "Permite nombres duplicados"
  end

  test "no debería permitir símbolos duplicados" do
    existente = create(:serie).simbolo
    assert build_stubbed(:serie, simbolo: existente).invalid?, "Permite símbolos duplicados"
  end

end
