require 'test_helper'

class CapacidadSerializerTest < ActiveSupport::TestCase
  subject { CapacidadSerializer.new(capacidad) }
  let(:capacidad) { create :capacidad, :con_clase, con_subclases: 2 }

  it 'al serializar devuelve los códigos de clase y subclases por separado' do
    codigos_subclases = capacidad.subclases.collect(&:codigo).join(' ')

    _(subject.serializable_hash).must_equal({
      clase: capacidad.clase.codigo,
      subclases: codigos_subclases
    })
  end
end
