# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :ficha do
    nombre { generate :cadena_unica }
    identificador { generate :cadena_unica }

    trait :default do
      identificador 'clasico'
      default true
    end
  end
end
