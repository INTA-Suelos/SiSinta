require './test/test_helper'

class SerieSerializerTest < ActiveSupport::TestCase
  subject { SerieSerializer.new serie }
  let(:serie) { build :serie }

  it 'serializa el nombre de Provincia' do
    serie.provincia =  build :provincia, nombre: 'Alguna'

    _(subject.serializable_hash[:provincia]).must_equal 'Alguna'
  end

  it 'serializa su nombre' do
    _(subject.serializable_hash[:nombre]).must_equal serie.nombre
  end

  it 'serializa su símbolo' do
    _(subject.serializable_hash[:simbolo]).must_equal serie.simbolo
  end

  it 'serializa su descripción' do
    serie.descripcion = 'algo'

    _(subject.serializable_hash[:descripcion]).must_equal 'algo'
  end
end
