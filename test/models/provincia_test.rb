require './test/test_helper'

class ProvinciaTest < ActiveSupport::TestCase
  subject { Provincia.find(rand(Provincia.all.size)) }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end
  end

  describe 'ubicaciones' do
    it 'devuelve una lista de ubicaciones' do
      subject.ubicaciones.must_be_instance_of Ubicacion::ActiveRecord_Relation
    end
  end
end
