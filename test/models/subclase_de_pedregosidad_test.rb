require 'test_helper'

class SubclaseDePedregosidadTest < ActiveSupport::TestCase
  subject { build_stubbed :subclase_de_pedregosidad }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build_stubbed(:subclase_de_pedregosidad, valor: nil).wont_be :valid?
    end
  end
end
