# encoding: utf-8
FactoryGirl.define do
  factory :perfil do
    numero  { generate :cadena_unica }
    fecha   { 2.days.ago }

    factory :perfil_futuro do
      fecha { 2.days.from_now }
    end

    factory :perfil_completo do
      usuario
      serie
      fase
      grupo

      association :capacidad, strategy: :build
      association :ubicacion, strategy: :build
      association :paisaje, strategy: :build
      association :humedad, strategy: :build
      association :erosion, strategy: :build
      association :pedregosidad, strategy: :build

      modal true
      publico true
      profundidad_napa { rand }
      cobertura_vegetal { rand }
      material_original 'sarasa'
      vegetacion_o_cultivos 'sarasa'
      observaciones 'sarasa'

      drenaje
      escurrimiento
      pendiente
      permeabilidad
      relieve
      anegamiento
      uso_de_la_tierra
      posicion

      # lookups
      sal_id              { rand(Sal.count) + 1 }

      transient { con_horizontes 1 }

      after :create do |perfil, params|
        params.con_horizontes.times { perfil.horizontes << create(:horizonte, perfil: perfil) }
      end
    end

    # Sólo los atributos y asociaciones que pasamos al GeoJSON
    factory :perfil_para_geojson do
      publico true
      serie
      association :ubicacion, :con_coordenadas, strategy: :build
    end
  end
end
