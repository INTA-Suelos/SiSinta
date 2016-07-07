require './test/test_helper'

describe Analitico do
  describe 'Campos con precision: 5, scale: 2' do
    let(:campos) do
      [
        :humedad, :arcilla, :carbono_organico_c, :limo_2_20, :limo_2_50,
        :arena_muy_fina, :arena_fina, :arena_media, :arena_gruesa,
        :arena_muy_gruesa, :arena_total, :ca_co3, :agua_15_atm, :agua_util,
        :saturacion_t, :saturacion_s_h, :agua_3_atm
      ]
    end

    it 'mantiene la precisión y usa BigDecimals' do
      campos.each do |campo|
        analitico = create(:horizonte, analitico_attributes: { campo => 99.99 }).analitico
        analitico.send(campo).must_equal BigDecimal('99.99'), "Falla para #{campo}"
      end
    end

    it 'redondea por fuera de la precisión' do
      campos.each do |campo|
        analitico = create(:horizonte, analitico_attributes: { campo => 99.999 }).analitico
        analitico.send(campo).must_equal BigDecimal('100.00'), "Falla para #{campo}"
      end
    end
  end

  describe 'Campos con precision: 6, scale: 3' do
    let(:campos) { [:carbono_organico_n] }

    it 'mantiene la precisión y usa BigDecimals' do
      campos.each do |campo|
        analitico = create(:horizonte, analitico_attributes: { campo => 0.004 }).analitico
        analitico.send(campo).must_equal BigDecimal('0.004'), "Falla para #{campo}"
      end
    end

    it 'redondea por fuera de la precisión' do
      campos.each do |campo|
        analitico = create(:horizonte, analitico_attributes: { campo => 0.004999 }).analitico
        analitico.send(campo).must_equal BigDecimal('0.005'), "Falla para #{campo}"
      end
    end
  end

  describe 'Campos con precision: 20, scale: 1' do
    let(:campos) { [:carbono_organico_cn] }

    it 'mantiene la precisión y usa BigDecimals' do
      campos.each do |campo|
        # Crearlo con float falla para este número
        analitico = create(:horizonte, analitico_attributes: { campo => BigDecimal('999999999999999999.9') }).analitico
        analitico.send(campo).must_equal BigDecimal('999999999999999999.9'), "Falla para #{campo}"
      end
    end

    it 'redondea por fuera de la precisión' do
      campos.each do |campo|
        analitico = create(:horizonte, analitico_attributes: { campo => 999999999999999999.99 }).analitico
        analitico.send(campo).must_equal BigDecimal('1000000000000000000.0'), "Falla para #{campo}"
      end
    end
  end

  describe 'Campos con precision: 4, scale: 1' do
    let(:campos) { [:p_ppm] }

    it 'está entre 0 y 100' do
      build(:analitico, horizonte: build(:horizonte), p_ppm: 100.1).wont_be :valid?
      build(:analitico, horizonte: build(:horizonte), p_ppm: 50.1).must_be :valid?
      build(:analitico, horizonte: build(:horizonte), p_ppm: -0.1).wont_be :valid?
    end

    it 'usa precisión 000.0' do
      a = create(:horizonte, analitico_attributes: { p_ppm: 0.41 }).analitico

      a.reload.p_ppm.to_f.must_equal 0.4
    end

    it 'mantiene la precisión y usa BigDecimals' do
      campos.each do |campo|
        analitico = create(:horizonte, analitico_attributes: { campo => 0.4 }).analitico
        analitico.send(campo).must_equal BigDecimal('0.4'), "Falla para #{campo}"
      end
    end

    it 'redondea por fuera de la precisión' do
      campos.each do |campo|
        analitico = create(:horizonte, analitico_attributes: { campo => 0.49 }).analitico
        analitico.send(campo).must_equal BigDecimal('0.5'), "Falla para #{campo}"
      end
    end
  end

  describe 'porcentajes' do
    let(:campos) do
      [
        :carbono_organico_c, :carbono_organico_n, :ca_co3, :arcilla, :limo_2_20,
        :limo_2_50, :arena_muy_fina, :arena_fina, :arena_media, :arena_gruesa,
        :arena_muy_gruesa, :arena_total, :humedad, :agua_3_atm, :agua_15_atm,
        :agua_util, :saturacion_t, :saturacion_s_h, :p_ppm,
      ]
    end

    it 'están entre 0 y 100' do
      campos.each do |campo|
        build(:analitico, horizonte: build(:horizonte), campo => 100.1).wont_be :valid?
        build(:analitico, horizonte: build(:horizonte), campo => -0.1).wont_be :valid?

        build(:analitico, horizonte: build(:horizonte), campo => 100).must_be :valid?
        build(:analitico, horizonte: build(:horizonte), campo => 50).must_be :valid?
        build(:analitico, horizonte: build(:horizonte), campo => 0).must_be :valid?
      end
    end
  end
end
