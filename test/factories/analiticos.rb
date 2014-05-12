# encoding: utf-8
FactoryGirl.define do
  factory :analitico do
    registro { rand(100) }
    humedad           { generate(:porcentaje).round 2 }
    s                 { generate :porcentaje }
    t                 { generate :porcentaje }
    ph_pasta          { generate :porcentaje }
    ph_h2o            { generate :porcentaje }
    ph_kcl            { generate :porcentaje }
    resistencia_pasta { generate :porcentaje }
    base_ca           { generate :porcentaje }
    base_mg           { generate :porcentaje }
    base_k            { generate :porcentaje }
    base_na           { generate :porcentaje }
    profundidad_muestra "2 - 10"
  end
end
