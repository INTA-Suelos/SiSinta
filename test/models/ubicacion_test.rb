require './test/test_helper'

class UbicacionTest < ActiveSupport::TestCase
  subject { build(:ubicacion, coordenadas: punto) }
  let(:x) { -61.85 }
  let(:y) { -34.1725 }
  let(:punto) { "POINT(#{x} #{y})" }
  let(:rango_x) { Rails.application.config.rango_x }
  let(:rango_y) { Rails.application.config.rango_y }

  describe 'validaciones' do
    it 'requiere perfil' do
      build(:ubicacion).wont_be :valid?
      build(:ubicacion, :con_perfil).must_be :valid?
    end

    it 'requiere coordenadas bien formadas' do
      build(:ubicacion, coordenadas: 'rms').wont_be :valid?
    end

    it 'permite x dentro cierto rango' do
      x_validas = [-180, -180.0000, "-179° 60' 0\"", 0, "180°", -179.99999999, 180]

      x_validas.each do |x|
        build(:ubicacion, :con_perfil, x: x, y: 0).must_be :valid?
      end
    end

    it 'no permite x fuera de cierto rango' do
      x_invalidas = [-181, 180.000001, "-179° 60' 1\"", "180° 1'", -250]

      x_invalidas.each do |x|
        build(:ubicacion, :con_perfil, x: x, y: 0).wont_be :valid?
      end
    end

    it 'permite y dentro cierto rango' do
      y_validas = [-90, -90.0000, "24° 70'", 0, -89.99999999, 90, "89° 59' 59\"" ]

      y_validas.each do |y|
        build(:ubicacion, :con_perfil, x: 0, y: y).must_be :valid?
      end
    end

    it 'no permite x fuera de cierto rango' do
      y_invalidas = [90.000001, -250, "89° 60' 30\""]

      y_invalidas.each do |y|
        build(:ubicacion, :con_perfil, x: 0, y: y).wont_be :valid?
      end
    end
  end

  describe '#coordenadas' do
    it 'las guarda en SRID 4326' do
      subject.coordenadas.srid.must_equal 4326
    end

    it 'las crea a partir de (x, y)' do
      nueva = create(:ubicacion, :con_perfil, x: x, y: y)

      nueva.coordenadas.x.must_equal x
      nueva.coordenadas.y.must_equal y
    end

    it 'las anula si pasamos datos incompletos' do
      subject.x = nil

      subject.save

      subject.coordenadas.must_be :nil?
    end

    it 'las anula si pasamos datos en blanco' do
      subject.x = ''
      subject.y = ''

      subject.save

      subject.coordenadas.must_be :nil?
    end

    it 'srid, x e y son accesibles directamente' do
      subject.x.must_equal subject.coordenadas.x
      subject.y.must_equal subject.coordenadas.y
      subject.srid.must_equal subject.coordenadas.srid
    end

    it '(lat,lon) corresponde a (y,x)' do
      subject.latitud.must_equal y
      subject.longitud.must_equal x
    end
  end

  describe '#punto' do
    it 'representa un punto x y en String' do
      subject.punto.must_equal "#{x} #{y}"
    end

    it 'convierte la representación en String a x e y' do
      skip 'definir funcionamiento'
      nueva = build(:ubicacion, punto: '12 34')

      nueva.x.must_equal 12
      nueva.y.must_equal 34
    end
  end

  describe '#geolocalizado?' do
    it 'sin coordenadas no está geolocalizadx' do
      build(:ubicacion).wont_be :geolocalizado?
      build(:ubicacion).wont_be :geolocalizada?
    end

    it 'con coordenadas está geolocalizadx' do
      build(:ubicacion, coordenadas: punto).must_be :geolocalizado?
      build(:ubicacion, coordenadas: punto).must_be :geolocalizada?
    end
  end

  describe '#transformar_a_wgs84!' do
    it 'transforma a 4326' do
      coordenadas_previas = subject.coordenadas.dup

      subject.transformar_a_wgs84!(22177, '7180428.8164', '7550269.2664')

      subject.coordenadas.srid.wont_equal coordenadas_previas.srid
      subject.coordenadas.x.wont_equal coordenadas_previas.x
      subject.coordenadas.y.wont_equal coordenadas_previas.y
    end
  end

  describe '.grados_a_decimal' do
    it 'maneja coordenadas negativas' do
      Ubicacion.grados_a_decimal('-40 30').must_equal -40.5
      Ubicacion.grados_a_decimal('-179 50 30').must_equal -179.841667
    end
  end

  describe '.transformar' do
    let(:a_4326) { Ubicacion.transformar(22177, 4326, '7180428.8164', '7550269.2664') }
    let(:de_4326) { Ubicacion.transformar(4326, 22177, '-54', '-26') }

    it 'devuelve un punto' do
      # No todas las implementaciones de SFS de Rgeo necesitan incluir esta
      # interfaz/módulo pero las que usamos sí
      a_4326.must_be_kind_of RGeo::Feature::Point
    end

    it 'devuelve algo que habla como un punto' do
      [a_4326, de_4326].each do |punto|
        punto.respond_to?(:x).must_equal true
        punto.respond_to?(:y).must_equal true
        punto.respond_to?(:srid).must_equal true
      end
    end

    it 'devuelve un punto en el srid objetivo' do
      skip 'Investigar'
      a_4326.srid.must_equal 4326
      de_4326.srid.must_equal 22177
    end
  end

  describe 'GeoJSON' do
    let(:geojson_feature) { RGeo::GeoJSON::EntityFactory.instance.feature(subject.coordenadas) }

    it 'habla como feature' do
      geojson_feature.must_respond_to :geometry
    end

    it 'es codificable en GeoJSON' do
      geojson = RGeo::GeoJSON.encode(geojson_feature)

      geojson.must_be_kind_of Hash
      geojson['properties'].must_equal Hash.new
      geojson['type'].must_equal 'Feature'
      geojson['geometry']['type'].must_equal 'Point'
      geojson['geometry']['coordinates'].must_equal [subject.x, subject.y]
    end
  end
end
