require 'test_helper'

class HumedadSerializerTest < ActiveSupport::TestCase
  subject { HumedadSerializer.new(humedad) }
  let(:humedad) { create :humedad, :con_clase, con_subclases: 2 }

  it 'al serializar devuelve los valores de clase y subclases por separado' do
    valores_subclases = humedad.subclases.collect(&:valor).join(' ')

    _(subject.serializable_hash).must_equal({
      clase: humedad.clase.valor,
      subclases: valores_subclases
    })
  end
end
