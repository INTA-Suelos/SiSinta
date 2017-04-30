# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :estructura do
    horizonte
  end

  factory :tipo_de_estructura do
    valor { generate :cadena_unica }
  end

  factory :clase_de_estructura do
    valor { generate :cadena_unica }
  end

  factory :grado_de_estructura do
    valor { generate :cadena_unica }
  end
end
