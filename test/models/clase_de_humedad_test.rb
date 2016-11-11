require 'test_helper'

class ClaseDeHumedadTest < ActiveSupport::TestCase
  subject { build_stubbed :clase_de_humedad }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build_stubbed(:clase_de_humedad, valor: nil).wont_be :valid?
    end
  end
end
