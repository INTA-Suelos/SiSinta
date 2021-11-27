require 'test_helper'

class SubclaseDeCapacidadTest < ActiveSupport::TestCase
  subject { build_stubbed :subclase_de_capacidad }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere codigo' do
      _(build_stubbed(:subclase_de_capacidad, codigo: nil)).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { capacidad.subclases.first }
    let(:capacidad) { create :capacidad, con_subclases: 1 }

    it 'se recorre en ambos sentidos' do
      _(capacidad.subclases.first).must_equal subject

      _(subject.capacidades.first).must_equal capacidad
    end
  end
end
