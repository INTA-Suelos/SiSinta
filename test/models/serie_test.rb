require './test/test_helper'

class SerieTest < ActiveSupport::TestCase
  subject { build :serie }
  let(:provincia) { create :provincia }

  describe 'validaciones' do
    it 'es válida' do
      subject.must_be :valid?
    end

    it 'requiere el nombre' do
      build_stubbed(:serie, nombre: nil).wont_be :valid?
    end

    it 'no permite nombres duplicados dentro de la misma provincia' do
      create :serie, provincia: provincia, nombre: 'duplicado'

      build_stubbed(:serie, provincia: provincia, nombre: 'duplicado').wont_be :valid?
    end

    it 'no permite símbolos duplicados dentro de la misma provincia' do
      create :serie, provincia: provincia, simbolo: 'duplicado'

      build_stubbed(:serie, provincia: provincia, simbolo: 'duplicado').wont_be :valid?
    end

    it 'permite nombres duplicados en diferentes provincias' do
      create :serie, provincia: provincia, nombre: 'duplicado'

      build_stubbed(:serie, provincia: create(:provincia), nombre: 'duplicado').must_be :valid?
    end

    it 'permite símbolos duplicados en diferentes provincias' do
      create :serie, provincia: provincia, simbolo: 'duplicado'

      build_stubbed(:serie, provincia: create(:provincia), simbolo: 'duplicado').must_be :valid?
    end
  end

  describe '.cantidad_de_perfiles' do
    it 'el contador de perfiles inicia en 0' do
      subject.cantidad_de_perfiles.must_equal 0
      subject.save!
      subject.cantidad_de_perfiles.must_equal 0
    end

    it 'actualiza el contador de perfiles' do
      subject.update_attributes perfiles_attributes: [attributes_for(:perfil)]

      subject.reload.cantidad_de_perfiles.must_equal 1
    end
  end

  describe '.perfil_modal' do
    subject { create :serie }
    let(:modal) { create :perfil, modal: true, serie: subject }
    let(:no_modal) { create :perfil, modal: false, serie: subject }

    it 'accede a su perfil modal y viceversa' do
      modal.serie.must_equal subject

      subject.perfil_modal.must_equal modal
    end

    # TODO Verificar que éste sea el comportamiento buscado
    it 'un nuevo perfil modal reemplaza al anterior' do
      modal.must_be :persisted?
      subject.perfil_modal.must_equal modal
      subject.perfiles.count.must_equal 1

      nuevo_modal = create :perfil, modal: true, serie: subject

      subject.reload.perfil_modal.must_equal nuevo_modal
      subject.perfiles.count.must_equal 2
    end
  end
end
