# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :fase do
    codigo { generate(:cadena_unica).first 2 }
    nombre { generate :cadena_unica }
  end
end
