require 'test_helper'

class SubclaseDeHumedadTest < ActiveSupport::TestCase
  subject { build_stubbed :subclase_de_humedad }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build_stubbed(:subclase_de_humedad, valor: nil).wont_be :valid?
    end
  end
end
