require './test/test_helper'

class CSVSerializerTest < ActiveSupport::TestCase
  subject { CSVSerializer.new [perfil] }
  let(:perfil) { create(:perfil) }

  it 'genera un encabezado de todas las columnas' do
    # FIXME no usar la lógica interna para los datos de prueba
    todas_las_columnas = subject.send(
      :stub).serializable_hash.with_indifferent_access.sort.flatten_tree.keys

    _(todas_las_columnas).must_equal subject.encabezado
  end

  it 'limita las columnas del encabezado' do
    encabezado_restringido = ['analitico_registro', 'id', 'perfil_id']

    _(encabezado_restringido).must_equal subject.encabezado( %w{id analitico_registro perfil_id} )
  end

  describe 'con valores nulos' do
    let(:perfil) { create(:perfil, observaciones: nil) }

    it 'convierte valores nulos en celdas vacías' do
      csv = CSV.parse(subject.as_csv(
        checks: ['perfil_id', 'perfil_observaciones', 'perfil_numero']
      )).first

      _(csv[0]).must_equal perfil.id.to_s
      _(csv[1]).must_equal perfil.numero
      _(csv[2]).must_equal ''
    end
  end
end
