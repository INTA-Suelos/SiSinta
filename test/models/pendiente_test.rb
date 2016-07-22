require './test/test_helper'

class PendienteTest < ActiveSupport::TestCase
  subject { build(:pendiente) }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'require valor' do
      build(:pendiente, valor: nil).wont_be :valid?
    end
  end
end
