require './test/test_helper'

class PermeabilidadTest < ActiveSupport::TestCase
  subject { build(:permeabilidad) }

  describe 'validaciones' do
    it 'es válido' do
      _(subject).must_be :valid?
    end

    it 'require valor' do
      _(build(:permeabilidad, valor: nil)).wont_be :valid?
    end
  end
end
