require 'test_helper'

class SubclaseDeCapacidadTest < ActiveSupport::TestCase
  subject { build_stubbed :subclase_de_capacidad }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere codigo' do
      build_stubbed(:subclase_de_capacidad, codigo: nil).wont_be :valid?
    end
  end
end
