require 'test_helper'

class ClaseDePedregosidadTest < ActiveSupport::TestCase
  subject { build_stubbed :clase_de_pedregosidad }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere valor' do
      _(build_stubbed(:clase_de_pedregosidad, valor: nil)).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :clase_de_pedregosidad }
    let(:pedregosidad) { create :pedregosidad, clase: subject }

    it 'se recorre en ambos sentidos' do
      _(pedregosidad.clase).must_equal subject

      _(subject.pedregosidades.first).must_equal pedregosidad
    end
  end
end
