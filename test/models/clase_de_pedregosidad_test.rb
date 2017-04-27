require 'test_helper'

class ClaseDePedregosidadTest < ActiveSupport::TestCase
  subject { build_stubbed :clase_de_pedregosidad }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build_stubbed(:clase_de_pedregosidad, valor: nil).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :clase_de_pedregosidad }
    let(:pedregosidad) { create :pedregosidad, clase: subject }

    it 'se recorre en ambos sentidos' do
      pedregosidad.clase.must_equal subject

      subject.pedregosidades.first.must_equal pedregosidad
    end
  end
end
