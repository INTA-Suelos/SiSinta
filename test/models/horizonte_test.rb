require './test/test_helper'

class HorizonteTest < ActiveSupport::TestCase
  subject { build :horizonte }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'requiere perfil' do
      build(:horizonte, perfil: nil).wont_be :valid?
    end

    it 'profundidad_inferior debe estar entre 0 y 2000' do
      build(:horizonte, profundidad_inferior: -1).wont_be :valid?

      build(:horizonte, profundidad_inferior: 0).must_be :valid?
      build(:horizonte, profundidad_inferior: 100).must_be :valid?
      build(:horizonte, profundidad_inferior: 1000).must_be :valid?
      build(:horizonte, profundidad_inferior: 2000).must_be :valid?

      build(:horizonte, profundidad_inferior: 2001).wont_be :valid?
    end

    it 'profundidad_superior debe estar entre 0 y 2000' do
      build(:horizonte, profundidad_superior: -1).wont_be :valid?

      build(:horizonte, profundidad_superior: 0).must_be :valid?
      build(:horizonte, profundidad_superior: 100).must_be :valid?
      build(:horizonte, profundidad_superior: 1000).must_be :valid?
      build(:horizonte, profundidad_superior: 2000).must_be :valid?

      build(:horizonte, profundidad_superior: 2001).wont_be :valid?
    end
  end

  describe 'colores' do
    it 'los crea cuando no existen' do
      lambda do
        create :horizonte, color_seco_attributes: { hvc: 'un color que valide' },
                           color_humedo_attributes: { hvc: 'otro color que valide' }
      end.must_change 'Color.count', 2
    end

    it 'los asocia cuando existen previamente' do
      existente = create(:color, hvc: 'sarasa')

      lambda do
        horizonte = create :horizonte,
          color_seco_attributes: { hvc: 'sarasa' },
          color_humedo_attributes: { hvc: 'sarasa' }

        horizonte.color_seco.must_equal existente
        horizonte.color_humedo.must_equal existente
      end.wont_change 'Color.count'
    end
  end
end
