require 'test_helper'

class GradoDeEstructuraTest < ActiveSupport::TestCase
  subject { build :grado_de_estructura }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'no permite valores duplicados' do
      subject.save

      build(:grado_de_estructura, valor: subject.valor).wont_be :valid?
    end
  end
end
