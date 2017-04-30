require 'test_helper'

class ColorTest < ActiveSupport::TestCase
  subject { build_stubbed :color }
  let(:existente) { create :color }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'requiere hvc' do
      build_stubbed(:color, hvc: nil).wont_be :valid?
    end

    it 'hvc debe ser único' do
      build_stubbed(:color, hvc: existente.hvc).wont_be :valid?
    end
  end

  describe 'asociaciones' do
    subject { create :color }
    let(:horizonte_seco) { create :horizonte, color_seco: subject }
    let(:horizonte_humedo) { create :horizonte, color_humedo: subject }

    it 'se recorre en ambos sentidos' do
      horizonte_seco.color_seco.must_equal subject
      subject.horizontes_en_seco.first.must_equal horizonte_seco

      horizonte_humedo.color_humedo.must_equal subject
      subject.horizontes_en_humedo.first.must_equal horizonte_humedo
    end
  end
end
