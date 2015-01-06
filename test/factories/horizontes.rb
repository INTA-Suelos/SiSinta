# encoding: utf-8
FactoryGirl.define do
  factory :horizonte do
    perfil
    sequence(:profundidad_superior) { |n| n + 4 }
    profundidad_inferior { profundidad_superior + 2 }
    ph 1.5

    factory :horizonte_completo do
      association :analitico, factory: :analitico_completo
      limite
      consistencia
      estructura
      color_seco
      color_humedo

      humedad { generate :cadena_unica }
      raices { generate :cadena_unica }
      formaciones_especiales { generate :cadena_unica }
      moteados { generate :cadena_unica }
      barnices { generate :cadena_unica }
      concreciones { generate :cadena_unica }
      co3 { generate :cadena_unica }
      tipo { generate :cadena_unica }

      textura_id { rand(TexturaDeHorizonte.count) + 1 }
    end
  end
end
