require './test/test_helper'

describe Capacidad do
  let(:capacidad) { build_stubbed :capacidad }

  it 'carga la clase asociada' do
    lambda do
      create(:capacidad, :con_perfil).update_attributes clase_id: ClaseDeCapacidad.first.id
    end.must_change'ClaseDeCapacidad.first.capacidades.count'
  end

  it 'guarda la relación con una subclase' do
    capacidad = create(:capacidad, :con_perfil, subclase_ids: [ SubclaseDeCapacidad.first.id ])

    capacidad.must_be :valid?
    capacidad.subclase_ids.include?(SubclaseDeCapacidad.first.id).must_equal true
    capacidad.subclases.include?(SubclaseDeCapacidad.first).must_equal true
  end

  it 'guarda la relación con varias subclases' do
    atributos = { subclase_ids: [ SubclaseDeCapacidad.first.id,
                                  SubclaseDeCapacidad.last.id   ] }
    capacidad = create(:capacidad, :con_perfil, atributos)

    capacidad.must_be :valid?
    capacidad.subclase_ids.include?(SubclaseDeCapacidad.first.id).must_equal true
    capacidad.subclases.include?(SubclaseDeCapacidad.first).must_equal true
    capacidad.subclase_ids.include?(SubclaseDeCapacidad.last.id).must_equal true
    capacidad.subclases.include?(SubclaseDeCapacidad.last).must_equal true
  end

  it 'requiere un perfil' do
    build_stubbed(:capacidad, :sin_perfil).must_be :invalid?
  end

  it 'puede acceder a sus asociaciones' do
    capacidad.respond_to?(:clase).must_equal true
    capacidad.respond_to?(:subclases).must_equal true
    capacidad.respond_to?(:perfil).must_equal true

    # Pruebo sus lookups
    ClaseDeCapacidad.first.respond_to?(:capacidades).must_equal true
    SubclaseDeCapacidad.first.respond_to?(:capacidades).must_equal true
  end

  it 'ignora elementos vacíos' do
    capacidad.subclase_ids = [1, '', nil, 2]

    capacidad.subclase_ids.must_equal [1, 2]
  end

  it 'ignora ids inexistentes' do
    capacidad.subclase_ids = [1, '2', (SubclaseDeCapacidad.count + 1)]

    capacidad.subclase_ids.must_equal [1, 2]
  end
end
