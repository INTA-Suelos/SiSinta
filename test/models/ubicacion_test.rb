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
      _(build(:ubicacion)).wont_be :valid?
      _(build(:ubicacion, :con_perfil)).must_be :valid?
    end

    it 'requiere coordenadas bien formadas' do
      _(build(:ubicacion, coordenadas: 'rms')).wont_be :valid?
    end

    it 'permite x dentro cierto rango' do
      x_validas = [-180, -180.0000, "-179° 60' 0\"", 0, "180°", -179.99999999, 180]

      x_validas.each do |x|
        _(build(:ubicacion, :con_perfil, x: x, y: 0)).must_be :valid?
      end
    end

    it 'no permite x fuera de cierto rango' do
      x_invalidas = [-181, 180.000001, "-179° 60' 1\"", "180° 1'", -250]

      x_invalidas.each do |x|
        _(build(:ubicacion, :con_perfil, x: x, y: 0)).wont_be :valid?
      end
    end

    it 'permite y dentro cierto rango' do
      y_validas = [-90, -90.0000, "24° 70'", 0, -89.99999999, 90, "89° 59' 59\"" ]

      y_validas.each do |y|
        _(build(:ubicacion, :con_perfil, x: 0, y: y)).must_be :valid?
      end
    end

    it 'no permite x fuera de cierto rango' do
      y_invalidas = [90.000001, -250, "89° 60' 30\""]

      y_invalidas.each do |y|
        _(build(:ubicacion, :con_perfil, x: 0, y: y)).wont_be :valid?
      end
    end
  end

  describe '#coordenadas' do
    it 'las guarda en SRID 4326' do
      _(subject.coordenadas.srid).must_equal 4326
    end

    it 'las crea a partir de (x, y)' do
      nueva = create(:ubicacion, :con_perfil, x: x, y: y)

      _(nueva.coordenadas.x).must_equal x
      _(nueva.coordenadas.y).must_equal y
    end

    it 'las anula si pasamos datos incompletos' do
      subject.x = nil

      subject.save

      _(subject.coordenadas).must_be :nil?
    end

    it 'las anula si pasamos datos en blanco' do
      subject.x = ''
      subject.y = ''

      subject.save

      _(subject.coordenadas).must_be :nil?
    end

    it 'srid, x e y son accesibles directamente' do
      _(subject.x).must_equal subject.coordenadas.x
      _(subject.y).must_equal subject.coordenadas.y
      _(subject.srid).must_equal subject.coordenadas.srid
    end

    it '(lat,lon) corresponde a (y,x)' do
      _(subject.latitud).must_equal y
      _(subject.longitud).must_equal x
    end
  end

  describe '#punto' do
    it 'representa un punto x y en String' do
      _(subject.punto).must_equal "#{x} #{y}"
    end

    it 'convierte la representación en String a x e y' do
      skip 'definir funcionamiento'
      nueva = build(:ubicacion, punto: '12 34')

      _(nueva.x).must_equal 12
      _(nueva.y).must_equal 34
    end
  end

  describe '#geolocalizado?' do
    it 'sin coordenadas no está geolocalizadx' do
      _(build(:ubicacion)).wont_be :geolocalizado?
      _(build(:ubicacion)).wont_be :geolocalizada?
    end

    it 'con coordenadas está geolocalizadx' do
      _(build(:ubicacion, coordenadas: punto)).must_be :geolocalizado?
      _(build(:ubicacion, coordenadas: punto)).must_be :geolocalizada?
    end
  end

  describe '#transformar_a_wgs84!' do
    before do
      create :formato_de_coordenadas, srid: 4326
      create :formato_de_coordenadas, srid: 22177
    end

    it 'transforma a 4326' do
      coordenadas_previas = subject.coordenadas.dup

      subject.transformar_a_wgs84!(22177, '7180428.8164', '7550269.2664')

      _(subject.coordenadas.srid).wont_equal coordenadas_previas.srid
      _(subject.coordenadas.x).wont_equal coordenadas_previas.x
      _(subject.coordenadas.y).wont_equal coordenadas_previas.y
    end
  end

  describe '.grados_a_decimal' do
    it 'maneja coordenadas negativas' do
      _(Ubicacion.grados_a_decimal('-40 30')).must_equal -40.5
      _(Ubicacion.grados_a_decimal('-179 50 30')).must_equal -179.841667
    end
  end

  describe '.transformar' do
    before do
      create :formato_de_coordenadas, srid: 4326
      create :formato_de_coordenadas, srid: 22177
    end

    let(:a_4326) { Ubicacion.transformar(22177, 4326, '7180428.8164', '7550269.2664') }
    let(:de_4326) { Ubicacion.transformar(4326, 22177, '-54', '-26') }

    it 'devuelve un punto' do
      # No todas las implementaciones de SFS de Rgeo necesitan incluir esta
      # interfaz/módulo pero las que usamos sí
      _(a_4326).must_be_kind_of RGeo::Feature::Point
    end

    it 'devuelve algo que habla como un punto' do
      [a_4326, de_4326].each do |punto|
        _(punto.respond_to?(:x)).must_equal true
        _(punto.respond_to?(:y)).must_equal true
        _(punto.respond_to?(:srid)).must_equal true
      end
    end

    it 'devuelve un punto en el srid objetivo' do
      skip 'Investigar'
      _(a_4326.srid).must_equal 4326
      _(de_4326.srid).must_equal 22177
    end
  end

  describe 'GeoJSON' do
    let(:geojson_feature) { RGeo::GeoJSON::EntityFactory.instance.feature(subject.coordenadas) }

    it 'habla como feature' do
      _(geojson_feature).must_respond_to :geometry
    end

    it 'es codificable en GeoJSON' do
      geojson = RGeo::GeoJSON.encode(geojson_feature)

      _(geojson).must_be_kind_of Hash
      _(geojson['properties']).must_equal Hash.new
      _(geojson['type']).must_equal 'Feature'
      _(geojson['geometry']['type']).must_equal 'Point'
      _(geojson['geometry']['coordinates']).must_equal [subject.x, subject.y]
    end
  end

  describe '::en_provincias' do
    it 'devuelve una lista de ubicaciones' do
      resultado = Ubicacion.en_provincias create(:provincia).to_param, IgnProvincia

      _(resultado).must_be_instance_of Ubicacion::ActiveRecord_Relation
    end

    it 'devuelve una relación vacía si data_oficial no tiene polígonos' do
      resultado = Ubicacion.en_provincias create(:provincia).to_param, nil

      _(resultado).must_be_instance_of Ubicacion::ActiveRecord_Relation
      _(resultado).must_be :empty?
    end
  end

  describe '::en_poligonos' do
    it 'devuelve una lista de ubicaciones' do
      _(Ubicacion.en_poligonos(
        IgnProvincia.arel_table[:geom]
      )).must_be_instance_of Ubicacion::ActiveRecord_Relation
    end
  end
end
