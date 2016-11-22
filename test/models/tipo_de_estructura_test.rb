require 'test_helper'

class TipoDeEstructuraTest < ActiveSupport::TestCase
  subject { build :tipo_de_estructura }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'no permite valores duplicados' do
      subject.save

      build(:tipo_de_estructura, valor: subject.valor).wont_be :valid?
    end
  end
end
