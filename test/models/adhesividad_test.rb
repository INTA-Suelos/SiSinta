require './test/test_helper'

class AdhesividadTest < ActiveSupport::TestCase
  subject { build_stubbed(:adhesividad) }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere valor' do
      build_stubbed(:adhesividad, valor: nil).wont_be :valid?
    end
  end
end
