# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :subclase_de_capacidad do
    codigo { generate :cadena_unica }

    trait :completa do
      descripcion { generate :cadena_unica }
    end
  end
end
