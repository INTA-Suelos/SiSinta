# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :analitico do
    trait :con_horizonte do
      horizonte
    end

    trait :con_datos do
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
      arcilla { generate(:porcentaje).round 2 }
      carbono_organico_c { generate :porcentaje }
      carbono_organico_n { generate :porcentaje }
      limo_2_20 { generate(:porcentaje).round 2 }
      limo_2_50 { generate(:porcentaje).round 2 }
      arena_muy_fina { generate(:porcentaje).round 2 }
      arena_fina { generate(:porcentaje).round 2 }
      arena_media { generate(:porcentaje).round 2 }
      arena_gruesa { generate(:porcentaje).round 2 }
      arena_muy_gruesa { generate(:porcentaje).round 2 }
      ca_co3 { generate(:porcentaje).round 2 }
      agua_3_atm { generate(:porcentaje).round 2 }
      agua_15_atm { generate(:porcentaje).round 2 }
      agua_util { generate(:porcentaje).round 2 }
      conductividad { rand 100 }
      h { rand 100 }
      saturacion_t { generate(:porcentaje).round 2 }
      saturacion_s_h { generate(:porcentaje).round 2 }
      densidad_aparente { rand 100 }
      profundidad_muestra '2 - 10'
      carbono_organico_cn { rand }
      gravas { generate :porcentaje }
      arena_total { generate :porcentaje }
      base_al { generate :porcentaje }
      p_ppm { generate(:porcentaje).round(1) }
    end
  end
end
