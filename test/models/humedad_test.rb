require 'test_helper'

class HumedadTest < ActiveSupport::TestCase
  subject { build_stubbed :humedad }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere perfil' do
      build_stubbed(:humedad, perfil: nil).wont_be :valid?
    end
  end
end
