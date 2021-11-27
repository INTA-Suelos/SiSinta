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
        spec = lambda { |perfiles, usuario| _(usuario).must_equal 'juan@salvo.com.ar' }

        Deserializador.stub :new, spec do
          Deserializador.deserializar_perfiles(perfiles, 'juan@salvo.com.ar')
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
    end
  end

  describe 'Builder' do
    let(:usuario) { create(:usuario) }
    let(:csv) { CSVSerializer.new([build(:perfil)]).as_csv headers: true }
    subject { Deserializador.new(csv.parse_csv, usuario.email).construir }

    it 'construye al usuario por el email' do
      _(subject.usuario_id).must_equal usuario.id
    end
  end
end
