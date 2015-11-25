require './test/test_helper'

describe Analitico do

  let(:analitico) { build_stubbed(:analitico) }

  it 'usa precisión 000.00 en los porcentajes' do
    a = create(:analitico, horizonte: build(:horizonte),
      humedad: 99.98,
      arcilla: 0.01,
      carbono_organico_c: 100,
      limo_2_20: 0.04,
      limo_2_50: '100',
      arena_muy_fina: 0.06,
      arena_fina: 100.000,
      arena_media: 0.08,
      arena_gruesa: 0.09,
      arena_muy_gruesa: 0.10,
      ca_co3: 0.11,
      agua_15_atm: 0.12,
      agua_util: 0.13,
      saturacion_t: 0.14,
      saturacion_s_h: 0.15,
      agua_3_atm: 0.16 )

    a.humedad.must_equal 99.98
    a.arcilla.must_equal 0.01
    a.carbono_organico_c.must_equal 100
    a.limo_2_20.must_equal 0.04
    a.limo_2_50.must_equal 100
    a.arena_muy_fina.must_equal 0.06
    a.arena_fina.must_equal 100.00
    a.arena_media.must_equal 0.08
    a.arena_gruesa.must_equal 0.09
    a.arena_muy_gruesa.must_equal 0.10
    a.ca_co3.must_equal 0.11
    a.agua_15_atm.must_equal 0.12
    a.agua_util.must_equal 0.13
    a.saturacion_t.must_equal 0.14
    a.saturacion_s_h.must_equal 0.15
    a.agua_3_atm.must_equal 0.16
  end

  describe '#carbono_organico_cn' do
    it 'usa precisión 000.000' do
      a = create(:analitico, horizonte: build(:horizonte),
        carbono_organico_n: 0.004 )

      a.reload.carbono_organico_n.to_f.must_equal 0.004
    end
  end

  describe '#carbono_organico_cn' do
    it 'usa precisión 000000000000000000.0' do
      a = create(:analitico, horizonte: build(:horizonte),
        carbono_organico_cn: 0.3)

      a.carbono_organico_cn.must_equal 0.3

      a.update_attribute :carbono_organico_cn, 999999999999999999.9

      a.reload.carbono_organico_cn.to_f.must_equal 999999999999999999.9
    end
  end
end
