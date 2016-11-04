# Creación de modelos para los tests. Sin argumentos ni traits debería crear
# modelos que pasen la validación.
FactoryGirl.define do
  factory :serie do
    nombre  { generate :cadena_unica }
    simbolo { generate :cadena_unica }

    factory :serie_anonima do
      nombre nil
    end
  end
end
