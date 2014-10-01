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
      capacidad
      ubicacion
      paisaje
      humedad
      erosion
      pedregosidad
      modal true
      publico true
      profundidad_napa { rand }
      cobertura_vegetal { rand }
      material_original 'sarasa'
      vegetacion_o_cultivos 'sarasa'
      observaciones 'sarasa'

      # lookups
      drenaje_id          { rand(Drenaje.count) + 1 }
      relieve_id          { rand(Relieve.count) + 1 }
      posicion_id         { rand(Posicion.count) + 1 }
      pendiente_id        { rand(Pendiente.count) + 1 }
      escurrimiento_id    { rand(Escurrimiento.count) + 1 }
      permeabilidad_id    { rand(Permeabilidad.count) + 1 }
      anegamiento_id      { rand(Anegamiento.count) + 1 }
      sal_id              { rand(Sal.count) + 1 }
      uso_de_la_tierra_id { rand(UsoDeLaTierra.count) + 1 }

      after :create do |perfil|
        perfil.horizontes << create(:horizonte)
      end
    end

    # Sólo los atributos y asociaciones que pasamos al GeoJSON
    factory :perfil_para_geojson do
      publico true
      serie
      association :ubicacion, :con_coordenadas
    end
  end
end
