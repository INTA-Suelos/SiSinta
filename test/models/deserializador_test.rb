require './test/test_helper'

class DeserializadorTest < ActiveSupport::TestCase
  describe 'Parser' do
    let(:archivo) { Rails.root.join('test', 'data', 'cosas.csv') }
    let(:perfiles) { Deserializador.parsear_csv(archivo, :llave) }

    describe '.parsear_csv' do
      subject { Deserializador.parsear_csv(archivo, :llave) }

      it 'agrupa las filas en un Hash' do
        _(subject).must_be_instance_of Hash
      end

      it 'agrupa las filas por la llave indicada' do
        _(subject.keys).must_equal %w{1 2 3}
      end

      it 'acumula las filas en Arrays' do
        subject.values.each do |grupo|
          _(grupo).must_be_instance_of Array
        end
      end

      it 'acumula las filas en base al valor de la llave' do
        _(subject['1'].size).must_equal 1
        _(subject['2'].size).must_equal 2
        _(subject['3'].size).must_equal 3
      end

      it 'acumula filas con metadata (header)' do
        subject.values.flatten.each do |fila|
          _(fila).must_be_instance_of CSV::Row
          _(fila['a']).must_equal 'a'
          _(fila['b']).must_equal 'b'
          _(fila['c']).must_equal 'c'
        end
      end
    end

    describe '.deserializar_perfiles' do
      subject { Deserializador.deserializar_perfiles(perfiles) }

      it 'instancia un Deserializador por Perfil' do
        _(subject.size).must_equal perfiles.size
      end

      it 'devuelve una colección de Deserializador' do
        subject.each do |d|
          _(d).must_be_instance_of Deserializador
        end
      end

      it 'pasa el usuario a los deserializadores' do
        spec = lambda do |perfiles, opciones|
          _(opciones[:usuario]).must_equal 'juan@salvo.com.ar'
        end

        Deserializador.stub :new, spec do
          Deserializador.deserializar_perfiles(perfiles, usuario: 'juan@salvo.com.ar')
        end
      end
    end

    describe '.construir_perfiles' do
      subject { Deserializador.construir_perfiles(perfiles) }

      it 'instancia un Perfil por llave' do
        _(subject.size).must_equal perfiles.size
      end

      it 'devuelve una colección de Perfil' do
        subject.each do |p|
          _(p).must_be_instance_of Perfil
        end
      end

      it 'instancia perfiles nuevos por omisión' do
        subject.each do |p|
          p.wont_be :persisted?
        end
      end
    end
  end

  describe 'Builder' do
    let(:csv) do
      CSV.parse CSVSerializer.new([build(:perfil)]).as_csv(headers: true), headers: true
    end

    describe '#usuario' do
      let(:usuario) { create(:usuario) }

      it 'acepta un usuario' do
        deserializador = Deserializador.new(csv, usuario: usuario).construir

        _(deserializador.usuario).must_equal usuario
      end

      it 'acepta un email' do
        deserializador = Deserializador.new(csv, usuario: usuario.email).construir

        _(deserializador.usuario).must_equal usuario
      end

      it 'acepta nil' do
        deserializador = Deserializador.new(csv, usuario: nil).construir

        _(deserializador.usuario).must_equal nil
      end

      it 'acepta nada' do
        deserializador = Deserializador.new(csv).construir

        _(deserializador.usuario).must_equal nil
      end
    end

    describe '#actualizar?' do
      it 'crea los datos por omisión' do
        Deserializador.new(csv).actualizar?.must_equal false
      end

      it 'permite actualizar' do
        Deserializador.new(csv, actualizar: true).actualizar?.must_equal true
      end
    end

    describe '#construir_perfil' do
      it 'es nuevo por omisión' do
        Deserializador.new(csv).construir_perfil.wont_be :persisted?
      end

      it 'es existente si hay que actualizar' do
        perfil_existente = create(:perfil_completo)
        perfil_instanciado = Deserializador.new(
          CSV.parse(CSVSerializer.new([perfil_existente]).as_csv(headers: true), headers: true),
          actualizar: true
        ).construir_perfil

        perfil_instanciado.must_be :persisted?
        perfil_instanciado.must_equal perfil_existente
      end
    end
  end
end
