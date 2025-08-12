# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :horizonte do
    perfil

    profundidad_superior { rand(1500) }
    profundidad_inferior { rand(1500) }
    ph 1.5

    factory :horizonte_completo do
      association :analitico, :con_datos, strategy: :build
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

      textura_id { rand(Textura.count) + 1 }
    end
  end
end
