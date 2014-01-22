# encoding: utf-8
require './test/test_helper'

class PerfilTest < ActiveSupport::TestCase

  test "no guarda perfiles sin fecha" do
    c = Perfil.new
    assert c.invalid?, "no se puede guardar sin la fecha"
  end

  test "no guarda fechas del futuro" do
    assert build_stubbed(:perfil_futuro).invalid?, "la fecha es del futuro"
  end

  test "carga el paisaje asociado" do
    atributos = attributes_for(:perfil).merge(
      paisaje_attributes: { simbolo: "Ps" })
    assert_difference 'Paisaje.count' do
      c = Perfil.create(atributos)
      refute c.errors.any?
      assert c.valid?, "No valida"
    end
  end

  test "carga la ubicación asociada" do
    atributos = attributes_for(:perfil).merge(
      ubicacion_attributes: { descripcion: "Somewhere over the rainbow" } )
    assert_difference 'Ubicacion.count' do
      c = Perfil.create(atributos)
      refute c.errors.any?
      assert c.valid?, "No valida"
    end
  end

  test "crea una serie cuando no existe" do
    atributos_de_la_serie = attributes_for(:serie)
    assert_difference 'Serie.count', 1, "No crea la serie a partir del perfil" do
      create :perfil,
        serie_attributes: atributos_de_la_serie.slice(:nombre, :simbolo)
    end
    serie = Serie.find_by_nombre(atributos_de_la_serie[:nombre])
    assert_not_nil serie
    assert_equal atributos_de_la_serie[:nombre], serie.nombre
    assert_equal atributos_de_la_serie[:simbolo], serie.simbolo
  end

  test "crea una fase cuando no existe" do
    assert_difference 'Fase.count', 1, "No crea la fase a partir del perfil" do
      create :perfil,
        fase_attributes: attributes_for(:fase).slice(:nombre)
    end
  end

  test "crea un grupo cuando no existe" do
    assert_difference 'Grupo.count', 1, "No crea el grupo a partir del perfil" do
      create :perfil,
        grupo_attributes: attributes_for(:grupo).slice(:descripcion)
    end
  end

  test "asocia la serie si existe, sin cambiar el símbolo" do
    serie = create(:serie)
    assert_no_difference 'Serie.count', "Crea una serie nueva" do
      perfil = create(:perfil, serie_attributes: { nombre: serie.nombre, simbolo: 'no' })
      assert_equal serie, perfil.serie, "No le carga la serie existente"
    end
    assert_not_equal 'no', serie.reload.simbolo
  end

  test "carga el símbolo cuando la serie no tiene" do
    serie = create(:serie, simbolo: nil)
    assert_no_difference 'Serie.count', "Crea una serie nueva" do
      perfil = create :perfil,
        serie_attributes: serie.serializable_hash.slice("nombre").merge(simbolo: 'si')
      assert_equal serie, perfil.serie, "No le carga la serie existente"
    end
    assert_equal 'si', serie.reload.simbolo, "No le carga el símbolo a una serie existente"
  end

  test "asocia una fase si existe" do
    fase = create(:fase)
    assert_no_difference 'Fase.count', "Crea una fase nueva" do
      perfil = create :perfil,
        attributes_for(:perfil).merge(fase_attributes: fase.serializable_hash.slice("nombre"))
      assert_equal fase, perfil.fase, "No le carga la fase existente"
    end
  end

  test "asocia un grupo si existe" do
    grupo = create(:grupo)
    assert_no_difference 'Grupo.count', "Crea un grupo nuevo" do
      perfil = create :perfil,
        grupo_attributes: grupo.serializable_hash.slice("descripcion")
      assert_equal grupo, perfil.grupo, "No le carga el grupo existente"
    end
  end

  test "guarda y devuelve bien los tags" do
    perfil = create(:perfil)

    perfil.reconocedores = [ "Juan Salvo", "Favalli" ]
    perfil.etiquetas = %w{ nevado }

    assert perfil.save

    assert Perfil.tags(on: :etiquetas).pluck(:name).include? 'nevado'
    assert Perfil.tags(on: :reconocedores).pluck(:name).include? 'Favalli'
    assert Perfil.tags(on: :reconocedores).pluck(:name).include? 'Juan Salvo'
  end

  test "queda como único perfil modal de la serie" do
    serie = create(:serie)
    primer_modal = create(:perfil, modal: true, serie: serie)
    assert_equal 1, serie.perfiles.size
    nuevo_modal = create(:perfil, modal: true, serie: serie)
    assert_equal 2, serie.perfiles.size
    assert nuevo_modal.reload.modal, "Le sacó el modal al nuevo modal"
    refute primer_modal.reload.modal, "No le sacó el modal al primer modal"
  end

  test 'no permite números duplicados dentro de la serie' do
    serie = create(:serie)
    perfil = create(:perfil, serie: serie, numero: 'unico')
    repetido = build(:perfil, serie: serie, numero: 'unico')
    assert repetido.invalid?
    assert repetido.errors.messages[:numero].include?(
      I18n.t('activerecord.errors.models.perfil.attributes.numero.no_es_unico_en_la_serie'))
  end

  test 'devuelve perfiles con coordenadas' do
    con_todo = create :perfil, ubicacion: build(:ubicacion, x: 1, y: 1)
    sin_coordenadas = create :perfil, ubicacion: build(:ubicacion)
    sin_ubicacion = create :perfil

    assert_equal 1, Perfil.geolocalizados.count,
      'No debe devolver perfiles sin coordenadas'
    assert_equal con_todo, Perfil.geolocalizados.first,
      'Debe devolver perfiles con coodenadas cargadas'
  end
end
