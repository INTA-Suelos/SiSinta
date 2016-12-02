require './test/test_helper'

class FormatoDeCoordenadasTest < ActiveSupport::TestCase
  subject { build_stubbed :formato_de_coordenadas }

  describe 'validaciones' do
    it 'es válido' do
      subject.must_be :valid?
    end

    it 'requiere srid' do
      build_stubbed(:formato_de_coordenadas, srid: nil).wont_be :valid?
    end

    it 'requiere descripcion' do
      build_stubbed(:formato_de_coordenadas, descripcion: nil).wont_be :valid?
    end
  end

  describe '.fabrica' do
    it 'carga la fábrica de RGeo si existe' do
      subject.fabrica.must_be :present?
    end

    it 'devuelve la implementación de RGeo' do
      subject.fabrica.must_be_instance_of RGeo::Geographic::Factory
    end
  end

  describe '::fabrica' do
    subject { FormatoDeCoordenadas }

    it 'carga la fábrica de RGeo correspondiente al srid' do
      subject.fabrica(4326).must_be :present?
    end

    it 'devuelve la implementación de RGeo' do
      subject.fabrica(123456).must_be_instance_of RGeo::Geographic::Factory
    end
  end

  describe '::srid' do
    subject { FormatoDeCoordenadas }
    let(:existente) { create :formato_de_coordenadas }


    it 'devuelve el formato correspondiente al srid' do
      subject.srid(existente.srid).must_equal existente
    end

    it 'devuelve el formato correspondiente al srid usando strings' do
      subject.srid(existente.srid.to_s).must_equal existente
    end
  end
end
