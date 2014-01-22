# encoding: utf-8
require './test/test_helper'

class CSVSerializerTest < ActiveSupport::TestCase
  test 'genera un encabezado de todas las columnas' do
    serializador = CSVSerializer.new [ create(:perfil) ]

    # FIXME no usar la lógica interna para los datos de prueba
    todas_las_columnas = serializador.send(
      :stub).serializable_hash.with_indifferent_access.sort.flatten_tree.keys

    assert_equal todas_las_columnas, serializador.encabezado
  end

  test 'limita las columnas del encabezado' do
    serializador = CSVSerializer.new [ create(:perfil) ]

    assert_equal ['analitico_registro', 'id', 'perfil_id'],
      serializador.encabezado( %w{id analitico_registro perfil_id} )
  end

  test 'convierte valores nulos en celdas vacías' do
    perfil = create(:perfil, observaciones: nil)
    serializador = CSVSerializer.new [ perfil ]

    csv = CSV.parse(
      serializador.as_csv(
        checks: ['perfil_id', 'perfil_observaciones', 'perfil_numero']
      )).first

    assert_equal perfil.id.to_s,        csv[0]
    assert_equal perfil.numero,         csv[1]
    assert_equal '',                    csv[2]
  end
end
