require 'test_helper'

class SubclaseDePedregosidadTest < ActiveSupport::TestCase
  subject { build_stubbed :subclase_de_pedregosidad }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere valor' do
      _(build_stubbed(:subclase_de_pedregosidad, valor: nil)).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :subclase_de_pedregosidad }
    let(:pedregosidad) { create :pedregosidad, subclase: subject }

    it 'se recorre en ambos sentidos' do
      _(pedregosidad.subclase).must_equal subject

      _(subject.pedregosidades.first).must_equal pedregosidad
    end
  end
end
