require 'test_helper'

class ClaseDeEstructuraTest < ActiveSupport::TestCase
  subject { build :clase_de_estructura }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'no permite valores duplicados' do
      subject.save

      build(:clase_de_estructura, valor: subject.valor).wont_be :valid?
    end
  end
end
