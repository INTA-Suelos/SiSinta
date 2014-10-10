# encoding: utf-8
require './test/test_helper'

describe Deserializador do
  describe 'Parser' do
    let(:archivo) { Rails.root.join('test', 'data', 'cosas.csv') }

    describe '.parsear_perfiles_de_csv' do
      subject { Deserializador.parsear_perfiles_de_csv(archivo, :llave) }

      it 'agrupa las filas en un Hash' do
        subject.must_be_instance_of Hash
      end

      it 'agrupa las filas por la llave indicada' do
        subject.keys.must_equal %w{1 2 3}
      end

      it 'acumula las filas en Arrays' do
        subject.values.each do |grupo|
          grupo.must_be_instance_of Array
        end
      end

      it 'acumula las filas en base al valor de la llave' do
        subject['1'].size.must_equal 1
        subject['2'].size.must_equal 2
        subject['3'].size.must_equal 3
      end

      it 'acumula filas con metadata (header)' do
        subject.values.flatten.each do |fila|
          fila.must_be_instance_of CSV::Row
          fila['a'].must_equal 'a'
          fila['b'].must_equal 'b'
          fila['c'].must_equal 'c'
        end
      end
    end
  end
end
