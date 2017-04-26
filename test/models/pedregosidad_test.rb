require 'test_helper'

class PedregrosidadTest < ActiveSupport::TestCase
  subject { build_stubbed :pedregosidad }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere perfil' do
      build_stubbed(:pedregosidad, perfil: nil).wont_be :valid?
    end
  end
end
