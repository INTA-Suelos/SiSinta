# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :analitico do
    trait :completo do
      registro { rand(100) }
      humedad { generate(:porcentaje).round 2 }
      s { rand }
      t { rand }
      ph_pasta { generate :porcentaje }
      ph_h2o { generate :porcentaje }
      ph_kcl { generate :porcentaje }
      resistencia_pasta { generate :porcentaje }
      base_ca { generate :porcentaje }
      base_mg { generate :porcentaje }
      base_k { generate :porcentaje }
      base_na { generate :porcentaje }
      arcilla { generate :porcentaje }
      carbono_organico_c { generate :porcentaje }
      carbono_organico_n { generate :porcentaje }
      limo_2_20 { generate :porcentaje }
      limo_2_50 { generate :porcentaje }
      arena_muy_fina { generate :porcentaje }
      arena_fina { generate :porcentaje }
      arena_media { generate :porcentaje }
      arena_gruesa { generate :porcentaje }
      arena_muy_gruesa { generate :porcentaje }
      ca_co3 { rand }
      agua_15_atm { rand }
      agua_util { rand }
      conductividad { rand }
      h { rand }
      saturacion_t { generate :porcentaje }
      saturacion_s_h { generate :porcentaje }
      densidad_aparente { rand }
      profundidad_muestra '2 - 10'
      agua_3_atm { generate :porcentaje }
      carbono_organico_cn { rand }
      gravas { generate :porcentaje }
      arena_total { generate :porcentaje }
      base_al { generate :porcentaje }
      p_ppm { generate(:porcentaje).round(1) }
    end
  end
end
