require './test/test_helper'

class ProvinciaTest < ActiveSupport::TestCase
  subject { build :provincia }

  describe 'validaciones' do
    it 'es válida' do
      _(subject).must_be :valid?
    end

    it 'require nombre' do
      _(build(:provincia, nombre: nil)).wont_be :valid?
    end
  end

  describe 'ubicaciones' do
    it 'devuelve una lista de ubicaciones' do
      _(subject.ubicaciones).must_be_instance_of Ubicacion::ActiveRecord_Relation
    end
  end
end
