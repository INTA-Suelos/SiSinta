require 'test_helper'

class ClaseDeCapacidadTest < ActiveSupport::TestCase
  subject { create :clase_de_capacidad }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
        _(build_stubbed(:clase_de_capacidad)).must_be :valid?
    end

    it 'requiere codigo' do
      _(build_stubbed(:clase_de_capacidad, codigo: nil)).wont_be :valid?
    end

    it 'require codigo único' do
      _(build_stubbed(:clase_de_capacidad, codigo: subject.codigo)).wont_be :valid?
    end

    it 'permite códigos duplicados en diferentes locales' do
      codigo_es = subject.codigo

      Globalize.with_locale :en do
        _(build(:clase_de_capacidad, codigo: codigo_es)).must_be :valid?
      end
    end
  end

  describe 'asociaciones' do
    subject { create :clase_de_capacidad }
    let(:capacidad) { create :capacidad, clase: subject }

    it 'se recorre en ambos sentidos' do
      _(capacidad.clase).must_equal subject

      _(subject.capacidades.first).must_equal capacidad
    end
  end
end
