require 'test_helper'

class CapacidadTest < ActiveSupport::TestCase
  subject { build_stubbed :capacidad }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'requiere perfil' do
      _(build_stubbed(:capacidad, perfil: nil)).wont_be :valid?
    end
  end
end
